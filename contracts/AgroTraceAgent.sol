// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/// @title AgroTrace AI Agent
/// @notice Tracks agricultural products from farm to market with an on-chain
///         checkpoint history for traceability and verification.
contract AgroTraceAgent {
    enum Stage {
        Registered,
        Processing,
        Distribution,
        Market,
        Sold
    }

    struct Checkpoint {
        Stage stage;
        address handler;
        string location;
        string note;
        uint256 timestamp;
    }

    struct Product {
        uint256 id;
        string name;
        string origin;
        address farmer;
        uint256 createdAt;
        bool exists;
    }

    address public owner;
    uint256 private nextProductId = 1;

    mapping(uint256 => Product) public products;
    mapping(uint256 => Checkpoint[]) private productHistory;
    mapping(address => bool) public authorizedHandlers;

    event ProductRegistered(uint256 indexed productId, string name, string origin, address indexed farmer);
    event CheckpointAdded(uint256 indexed productId, Stage stage, address indexed handler, string location);
    event HandlerAuthorized(address indexed handler);
    event HandlerRevoked(address indexed handler);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized: owner only");
        _;
    }

    modifier onlyAuthorized() {
        require(msg.sender == owner || authorizedHandlers[msg.sender], "Not an authorized handler");
        _;
    }

    modifier productExists(uint256 productId) {
        require(products[productId].exists, "Product does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
        authorizedHandlers[msg.sender] = true;
    }

    /// @notice Register a new agricultural product batch on-chain.
    function registerProduct(string calldata name, string calldata origin) external onlyAuthorized returns (uint256) {
        uint256 productId = nextProductId++;

        products[productId] = Product({
            id: productId,
            name: name,
            origin: origin,
            farmer: msg.sender,
            createdAt: block.timestamp,
            exists: true
        });

        productHistory[productId].push(
            Checkpoint({
                stage: Stage.Registered,
                handler: msg.sender,
                location: origin,
                note: "Product registered",
                timestamp: block.timestamp
            })
        );

        emit ProductRegistered(productId, name, origin, msg.sender);
        return productId;
    }

    /// @notice Add a new supply-chain checkpoint (e.g. processing, distribution, market).
    function addCheckpoint(
        uint256 productId,
        Stage stage,
        string calldata location,
        string calldata note
    ) external onlyAuthorized productExists(productId) {
        productHistory[productId].push(
            Checkpoint({
                stage: stage,
                handler: msg.sender,
                location: location,
                note: note,
                timestamp: block.timestamp
            })
        );

        emit CheckpointAdded(productId, stage, msg.sender, location);
    }

    /// @notice Retrieve the full traceability history for a product.
    function getHistory(uint256 productId) external view productExists(productId) returns (Checkpoint[] memory) {
        return productHistory[productId];
    }

    /// @notice Retrieve the number of checkpoints recorded for a product.
    function getCheckpointCount(uint256 productId) external view productExists(productId) returns (uint256) {
        return productHistory[productId].length;
    }

    /// @notice Authorize an address (e.g. processor, distributor) to add checkpoints.
    function authorizeHandler(address handler) external onlyOwner {
        authorizedHandlers[handler] = true;
        emit HandlerAuthorized(handler);
    }

    /// @notice Revoke a handler's authorization.
    function revokeHandler(address handler) external onlyOwner {
        authorizedHandlers[handler] = false;
        emit HandlerRevoked(handler);
    }

    /// @notice Transfer contract ownership to a new address.
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        owner = newOwner;
        authorizedHandlers[newOwner] = true;
    }
}

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AgroTraceAgent", function () {
  let agroTraceAgent;
  let owner, farmer, processor, outsider;

  beforeEach(async function () {
    [owner, farmer, processor, outsider] = await ethers.getSigners();

    const AgroTraceAgent = await ethers.getContractFactory("AgroTraceAgent");
    agroTraceAgent = await AgroTraceAgent.deploy();
    await agroTraceAgent.waitForDeployment();
  });

  it("should set the deployer as owner and authorized handler", async function () {
    expect(await agroTraceAgent.owner()).to.equal(owner.address);
    expect(await agroTraceAgent.authorizedHandlers(owner.address)).to.equal(true);
  });

  it("should register a n

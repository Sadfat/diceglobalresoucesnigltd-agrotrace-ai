const hre = require("hardhat");

async function main() {
  console.log("Deploying AgroTraceAgent to Somnia Network...");

  const [deployer] = await hre.ethers.getSigners();
  console.log("Deploying with account:", deployer.address);

  const balance = await hre.ethers.provider.getBalance(deployer.address);
  console.log("Account balance:", hre.ethers.formatEther(balance), "STT");

  const AgroTraceAgent = await hre.ethers.getContractFactory("AgroTraceAgent");
  const agroTraceAgent = await AgroTraceAgent.deploy();

  await agroTraceAgent.waitForDeployment();

  const contractAddress = await agroTraceAgent.getAddress();
  console.log("AgroTraceAgent deployed to:", contractAddress);
  console.log("View on Shannon Explorer: https://shannon-explorer.somnia.network/address/" + contractAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

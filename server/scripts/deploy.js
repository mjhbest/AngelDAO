const { ethers } = require("hardhat");

async function main() {
    const Fundraising = await ethers.getContractFactory("Fundraising");
    const contract = await Fundraising.deploy(100000000000000000000);
    console.log("Contract address is:",contract.address);
}

main().then(() => process.exit(0)).catch((error) => {
    console.error(error);
    process.exit(1);
})
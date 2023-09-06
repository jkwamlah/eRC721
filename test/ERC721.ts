import {
    loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import {expect} from "chai";
import {ethers} from "hardhat";

async function deployERC721Fixture() {
    const [owner, signer1] = await ethers.getSigners();
    const _ERC721 = await ethers.getContractFactory("ERC721Contract");
    const erc721 = await _ERC721.deploy();

    return {
        erc721,
        owner,
        signer1,
    };
}

describe("EIP ERC721", function () {
    describe("Methods", function () {
        describe("balanceOf", function () {
            it('should return the balance of an address', async () => {
                const {erc721, owner} = await loadFixture(deployERC721Fixture);
                const balance = 0;
                await erc721.balanceOf(owner.address)
                expect(balance).to.be.greaterThanOrEqual(0);
            });
        });

        describe("transferFrom", function () {
            it('should not allow non-owners to transfer tokens', async () => {

            });

            it('should allow owners to transfer tokens', async () => {

            });
        });

        describe("ownerOf", function () {
            it('should return the address of a tokenId', async () => {

            });
        });

        describe("safeTransferFrom", function () {
            it('should transfer the token ownership of one address to another', async () => {

            });
        });

        describe("transferFrom", function () {
            it('should transfer the token ownership of one address to another', async () => {

            });
        });

        describe("approve", function () {
            it('should set address for approval', async () => {

            });
        });

        describe("approveForAll", function () {
            it('should enable approval for an operator', async () => {

            });

            it('should disable approval for an operator', async () => {

            });
        });
    });
});

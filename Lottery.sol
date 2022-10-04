// SPDX-License-Identifier: MIT
pragma solidity >= 0.6.0 < 0.9.0;

contract Lottery {

        uint public randomnes;

        address payable[] public players;
        address manager; // change
        address payable public winner; // newchange

        constructor() public  {
            manager = msg.sender;
        }

        function recieve() external payable {
            require(msg.value == 0.1 ether, "Please pay 0.1 ether only");
            players.push(payable(msg.sender));
        } 

        function getBalance() public view returns(uint) {
            require(msg.sender == manager, "You are not the manager");
            return address(this).balance;
        }

        //  function random() internal view returns (uint) {
        // return
        //     uint256(
        //         keccak256(
        //             abi.encodePacked(
        //                 block.difficulty,
        //                 block.timestamp,
        //                 players.length
        //             )
        //         )
        //     );
    // }
    // function randomNumber(uint min, uint max) public  returns(uint)  {
    //     return 
    //     (uint
    //     (keccak256
    //     (abi.encodePacked(randomnes, block.timestamp, block.difficulty)
    //     )
    //     )
    //     %max)
    //     + min;

    // }

    // function random(uint number) public view returns(uint){
    //     return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
    //     msg.sender))) % number;
    // }


    function random() private view returns (uint256) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
}


    function pickWinner() public  {
            require(msg.sender == manager, "You are not the manager");
            require(players.length >=3, "Players are less than 3");

            uint r = random();
            uint index = r % players.length;

            winner = players[index];
            winner.transfer(getBalance());
           players = new address payable[](0); 
    }
    
}



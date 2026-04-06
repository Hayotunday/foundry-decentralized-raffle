// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {
  VRFCoordinatorV2Interface
} from "@chainlink/contracts/vrf/interfaces/VRFCoordinatorV2Interface.sol";
import {
  VRFConsumerBaseV2
} from "@chainlink/contracts/vrf/VRFConsumerBaseV2.sol";
import {
  AutomationCompatibleInterface
} from "@chainlink/contracts/automation/interfaces/AutomationCompatibleInterface.sol";

contract DecentralizedRaffle is VRFConsumerBaseV2 {
  //// errors
  error DecentralizedRaffle__NotEnoughETHEntered();
  error DecentralizedRaffle__InvalidEntranceFee();
  error DecentralizedRaffle__InvalidMaxPlayers();
  error DecentralizedRaffle__RaffleNotOpen();
  error DecentralizedRaffle__PlayerCannotBeBurnAddress();
  error DecentralizedRaffle__RaffleReachedMaxPlayers();

  //// data structures
  enum RaffleState {
    OPEN,
    CLOSED,
    CALCULATING
  }

  //// state variables
  uint256 public winner;
  uint256 public immutable IENTRANCEFEE;
  uint256 public immutable IMAXPLAYERS;
  address[] public players;
  RaffleState public raffleState;
  VRFCoordinatorV2Interface public immutable vrfCoordinator;
  bytes32 public immutable keyHash;
  uint64 public immutable subId;
  uint16 public immutable minimumRequestConfirmations;
  uint32 public immutable callbackGasLimit;
  uint32 public immutable numWords;

  //// events
  event RaffleEntered(address indexed player);
  event RaffleWinnerPicked(address indexed winner);
  event RaffleClosed();

  //// functions
  //// modifiers
  modifier isRaffleOpen() {
    if (raffleState != RaffleState.OPEN) {
      revert DecentralizedRaffle__RaffleNotOpen();
    }
    _;
  }

  //// constructor
  constructor(
    uint256 _entranceFee,
    uint256 _maxPlayers,
    address _vrfCoordinator,
    address _link
  ) public VRFConsumerBase(_vrfCoordinator) {
    if (_entranceFee <= 0) {
      revert DecentralizedRaffle__InvalidEntranceFee();
    }
    if (_maxPlayers <= 0) {
      revert DecentralizedRaffle__InvalidMaxPlayers();
    }
    IENTRANCEFEE = _entranceFee;
    IMAXPLAYERS = _maxPlayers;
    raffleState = RaffleState.OPEN;
  }

  //// receive function to allow users to enter the raffle by sending ETH directly to the contract
  receive() external payable {
    enterRaffle();
  }

  //// public functions
  function enterRaffle() public payable isRaffleOpen {
    if (msg.value < IENTRANCEFEE) {
      revert DecentralizedRaffle__NotEnoughETHEntered();
    }
    if (msg.sender == address(0)) {
      revert DecentralizedRaffle__PlayerCannotBeBurnAddress();
    }
    if (players.length >= IMAXPLAYERS) {
      revert DecentralizedRaffle__RaffleReachedMaxPlayers();
    }

    players.push(msg.sender);
    emit RaffleEntered(msg.sender);

    _hasReachedMaxPlayers();
  }

  function getRaffleWinner() public view {}

  //// internal functions
  function _hasReachedMaxPlayers() internal {
    if (players.length >= IMAXPLAYERS) {
      raffleState = RaffleState.CALCULATING;
    }
  }

  function _setRaffleStateToClosed(RaffleState _state) external {
    raffleState = _state;
  }

  // function
}

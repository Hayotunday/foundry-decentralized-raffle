# Foundry Decentralized Raffle

A Foundry-based raffle smart contract prototype that lets users enter with ETH and compete for a prize using user-driven state transitions and verifiable randomness patterns. This project is designed to model a fair, permissionless raffle flow with a clear prize-selection lifecycle.

## What the product does
This project implements a raffle system where participants can pay an entry fee, join a pool, and wait for the contract to select a winner. The flow is managed with contract state, enforcement of max-player limits, and randomness-based selection logic.

The raffle is based around a state machine:
- open for entries
- closed when max players are reached
- calculating when randomness is being requested

## The problem it solves
Traditional prize draws often depend on centralized or opaque selection methods. On-chain raffles need to be transparent, enforceable, and verifiable. This prototype addresses that by encoding the rules directly into Solidity and using decentralized randomness patterns.

## My specific contribution
This repository implements the core raffle flow, user entry validation, raffle state management, and deployment scaffold. It establishes the core contract logic for entering a raffle, enforcing limits, and preparing for winner selection.

## Architecture
The repository includes:

- `src/DecentralizedRaffle.sol` — main raffle contract logic
- `src/Raffle.sol` — supporting raffle logic or alternate contract design
- `script/DecentralizedRaffle.s.sol` — deployment script
- `test/DecentralizedRaffle.t.sol` — tests for raffle behavior
- `lib/` — Foundry dependencies
- `foundry.toml` — Foundry project configuration

## Technologies
- Solidity
- Foundry
- Forge testing
- Chainlink VRF/automation-style integration patterns
- EVM state machine design

## Important technical decisions
- The contract uses explicit raffle states to control transitions between open, closed, and calculating states.
- Entry validation checks prevent invalid fees, zero-address users, and over-capacity entries.
- Custom errors make invalid conditions easier to inspect and test.
- The design supports future randomness integration for verifiable winner selection.

## Key features
- ETH-based raffle entry flow
- Configurable entrance fee and max-player cap
- Explicit error handling for invalid states
- Event-driven auditing of entries and winner selection
- State-based lifecycle management
- Extensible design for Chainlink VRF integration

## Screenshots
No screenshots are included in the repository.

## Live demo
No live deployment is included in this repository.

## Challenges and solutions
The biggest challenge in a raffle contract is ensuring fair winner selection while preventing abuse and state inconsistencies. This prototype works around that by separating state transitions and validating entry conditions before allowing players into the raffle.

It also keeps the logic modular and testable so that future randomness or automation integrations can be added without disrupting the contract design.

## Setup instructions
```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Clone
git clone https://github.com/Hayotunday/foundry-decentralized-raffle.git
cd foundry-decentralized-raffle

# Install dependencies
forge install

# Build
forge build

# Run tests
forge test

# Optional
forge fmt
forge snapshot
```

## What makes the project technically interesting
This project is interesting because it models a real on-chain game mechanic with financial participation, fairness concerns, and state transitions. It demonstrates how to express raffle logic in Solidity while keeping the system auditable, safe, and extendable.

## Project status
This is a prototype and learning project focused on decentralized raffle mechanics. It is not a production raffle platform, but it demonstrates the core enforcement logic needed for a fair on-chain draw.

## License
Follow the repository’s license file for the exact project terms.

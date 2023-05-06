// Copyright 2023 ComingChat Authors. Licensed under Apache-2.0 License.
module royalty::kiosk_royalty {
    use std::option::none;
    use sui::tx_context::{TxContext, sender};
    use sui::transfer_policy::{
        Self as policy,
        TransferPolicy,
        TransferPolicyCap,
        remove_rule,
        withdraw
    };
    use sui::package::Publisher;
    use sui::transfer;

    use kiosk::royalty_rule::{Self, Rule, Config};

    public entry fun new_kiosk_royalty<NFT: key + store>(
        publisher: &Publisher,
        amount_bp: u16,
        min_amount: u64,
        ctx: &mut TxContext
    ) {
        let (policy, cap) = policy::new<NFT>(publisher, ctx);

        royalty_rule::add<NFT>(&mut policy, &cap, amount_bp, min_amount);

        transfer::public_share_object(policy);
        transfer::public_transfer(cap, sender(ctx));
    }

    public entry fun update_kiosk_royalty<NFT: key + store>(
        policy: &mut TransferPolicy<NFT>,
        cap: &TransferPolicyCap<NFT>,
        amount_bp: u16,
        min_amount: u64
    ) {
        remove_rule<NFT, Rule, Config>(policy, cap);
        royalty_rule::add<NFT>(policy, cap, amount_bp, min_amount);
    }

    public entry fun withdraw_royalty<NFT: key + store>(
        policy: &mut TransferPolicy<NFT>,
        cap: &TransferPolicyCap<NFT>,
        beneficiary: address,
        ctx: &mut TxContext
    ) {
        let coin = withdraw(policy, cap, none<u64>(), ctx);
        transfer::public_transfer(coin, beneficiary)
    }
}
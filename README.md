# kiosk royalty

- Create some **Kiosk Royalty** policies for any sui NFT
- Update an existing **Kiosk Royalty** policy
- Withdraw all **Kiosk Royalty** fee

## publish
```bash
sui client publish --gas-budget 1000000000
```

## mainnet
**package=0xea5ca29c4ff1c9466cfe4b464e896479f88c07cb0e529201f318da2c340716a4**
upgradeCap=0x2f85e7731b920b376b86aee0bdc95832b1cf22b1fae10509eebda3b4c07fd71f
deployer=0x0f6e65716f1a33317c8914b24cc006475e6fafd797e34ffae72c76bf5ed4be12

NftPublisher=0x4d1418cc963fa0378c515901fd11d2bd29d04c6c4e797d5abc50151ffed245b5
NFT=0x6e8afef4fe19f8981ca0b651b2ca4e60191790b7cef2ba8664f0f2e073803f3d::suicat::SuiCat

### new_kiosk_royalty
```bash
sui client call --gas-budget 1000000000 \
    --package $package \
    --module kiosk_royalty \
    --function new_kiosk_royalty \
    --args $NftPublisher 500 100000000 \
    --type-args $NFT
```
**royaltyPolicy=0xb14bfebf22d4808bcd8bb2df2b681db26dce6c1c42194d5db1545df36b0cc580**
royaltyPolicyCap=0x1b49baf4d69c1fcb98c9b94202ded49b26c366c0f7d6a46b299fdf5b86516a11
royaltyRule=0xb14bfebf22d4808bcd8bb2df2b681db26dce6c1c42194d5db1545df36b0cc580

### update_kiosk_royalty
```bash
sui client call --gas-budget 1000000000 \
    --package $package \
    --module kiosk_royalty \
    --function update_kiosk_royalty \
    --args $royaltyPolicy $royaltyPolicyCap 500 100000000 \
    --type-args $NFT
```

### withdraw_royalty
```bash
sui client call --gas-budget 1000000000 \
    --package $package \
    --module kiosk_royalty \
    --function withdraw_royalty \
    --args $royaltyPolicy $royaltyPolicyCap 0x2c5476da42075b81416c8587d872e5952df2c784a0b1d9fd879abdb3881cac78 \
    --type-args $NFT
```

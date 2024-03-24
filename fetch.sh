#!/bin/bash


API_KEY="270feee3-eda4-4505-a6d7-b326be750b54"
ADDRESS="e18b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"


addresses='{"addresses":[{"balance":"0","hash":"013a3dbe375d1db71716352e5f8fd8218e103de1594b0727e607cbc2a68b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"018f58e1ada3d5c29408238b9b078dc609a9188bf205ad107f1c4291808b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"016cf87f7f32779dcba9d7c177fecde3a90a14046de890dc02aa6d605a8b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"016e8bea730bd4a1c5f268fc82c308e19f646a51cd046a23b8414dc5388b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"0138ca320e66d0dfa189c5357ef315be5265c3498f086d445e15a0690b8b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"01ebec56695efb48c62e285b16589198a406ad662085fe40d25b5555e88b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"01e735a9cfaa787c2ff6c8e4f2d8e582c34fefd3197b55fc1aa4686be08b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"014da1b8208b362277e0a810430a8a924098e59a90d863a047f76291bd8b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"014ea488b18a4d2c1e3f9a1878d0403c9197dc530bf1194bda84d688f18b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"0112ffc3f0589eb57b2dac5dab07bf0c856fb5e0877ae8732901e8bea08b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"0172156075cf139ba6e6e4fe3c6cffc023e26ea01eb432292d4da0bb7b8b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"},{"balance":"0","hash":"01f41fcf1c7c70b03ec63f3ac631e7801e1845036f9487b69995f926f08b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"}],"count":12,"pageNo":1,"limit":50}'
# curl \
#   -X GET "https://api.cardanoscan.io/api/v1/rewardAccount/addresses?rewardAddress=${ADDRESS}&pageNo=1&limit=50" \
#   -H "apiKey: $API_KEY"

addresses=`echo $addresses | jq -r '.addresses[] | .hash'`

for addr in ${addresses[*]}
do
  echo ">>> $addr"
  transactions='{"pageNo":1,"limit":50,"transactions":[{"hash":"1e3c7517b6fa1369c40da0a8fc1d5e123213ea228f6948614f70ea243c58b441","blockHash":"58877a61badb8200065a8e8e9d4bed2d268a3985475ddf887c01eee31fc0369a","fees":"871173","slot":364252,"epoch":256,"blockHeight":5529826,"absSlot":25593052,"timestamp":"2021-03-31T02:55:43.000Z","index":15,"inputs":[{"address":"Ae2tdPwUPEYzCXEj9U5S95hLNWSHPiwkHUxAE16Ut3mH3N7C6AgRJi1A9Pc","index":31,"txId":"00c6a6c8c46dca1bc5f7a9beb9c362bb2b8a84b5d055bc57673fec410e3e90d6","value":"32639349","tokens":[]},{"address":"Ae2tdPwUPEZ5EFSUiqzpoU4yAhP1sQ5TY1Wr3uyLDmZMx9KZVp6Ws7RvuZ5","index":14,"txId":"0c33ae41ec3173e2c7cee10eb05f4f41cbe0e440d74efb236d26744d0674da6b","value":"263261553","tokens":[]},{"address":"Ae2tdPwUPEYwQwSPtrB1Fd9HAWRGqbwgTsFPJo5FAehJyFogEccED3SAyy8","index":29,"txId":"0e6ba971a339f87fb538a7a590c7e21d7c110ebffe9f7148cabfed039ae53535","value":"42037370","tokens":[]},{"address":"Ae2tdPwUPEZJ8qw5CE3oQBuszRbC6uvtUidyu56T2NVb31Qb3XFQSJHJCpu","index":28,"txId":"10dd1ea6e96e802c585a8c7e098d507d17c56c377349342d39476104dd6cd97d","value":"258465020","tokens":[]},{"address":"Ae2tdPwUPEZKabcYdo7TiGEigbyeHwfBfv8JCfkYGFHKmyatU5cQM9q51Dc","index":29,"txId":"13ef2a7e5b6d7e87b074f930fb3cecfa1d507ebbd284b7f45e58c821ab662c52","value":"3388079548","tokens":[]},{"address":"Ae2tdPwUPEZFJ8bd6bVYwi9KxwtrpfrdQ3vNJ16QtW8v8p5u5sJEmZHabyx","index":39,"txId":"1620bfa0536a23276e6c70fb86a7df38ae7ab85dece781776f3701d584277a79","value":"485646313","tokens":[]},{"address":"Ae2tdPwUPEZJ2FKuCmyuXXa8HsYw4Q82PwXdjKPuZKmvW7KeEA6Hd3Wuqsi","index":4,"txId":"1cd52f875caedee53c5551abbe44ab61835de77e2507cb064d28e26a5d85e713","value":"43642316","tokens":[]},{"address":"Ae2tdPwUPEZEkq8FSUdiPP6VNmbfn1V37Zfh6fKxXjFfTtjCksb5CAV1Dbg","index":29,"txId":"1eafd8653ada396bd4f1a71d93cd74334f4a9358a064c05674bf550be416b267","value":"11525046215","tokens":[]},{"address":"Ae2tdPwUPEZ52rr9yRfS2dRas12y4QtymXfQ16YBmLa3QAHL8rVCEfckoUw","index":44,"txId":"20d96a671fd7a33c894c05c9d49150e70759c36141a928c64ebdac6543ee2588","value":"70482100","tokens":[]},{"address":"Ae2tdPwUPEZMoJm8p5nzmt39Se1zeTGggNZDWsbuNNaGibtAGeKmtCYa8QW","index":24,"txId":"21d1b2829b43aea25e63fd8bb4b50a610e6cfff9a61728ceca65573c463e23b9","value":"262903413","tokens":[]},{"address":"Ae2tdPwUPEZ8qjfkJ4e1sFykWmQkFzyYqd9SCrLQnRDbkMRcdUzJpe9Vf4N","index":21,"txId":"26f2cd320f0416be939676c60ae07376c5c9610a22c5226c109a54cf6a98749f","value":"26927687401","tokens":[]},{"address":"Ae2tdPwUPEZ3YFiavJ4kswbbpy9ipnxQywGur6jKfWDhX7ofxaDH2v1hcvZ","index":30,"txId":"2a526e913eebb068494dce402f49e0c6090658c624232902a817af8efafdd27d","value":"11099001","tokens":[]},{"address":"Ae2tdPwUPEZK4csujzzCrancSeVgPgfj4YBj5tcuXfbQ8RVWgAfphhJ8bhU","index":39,"txId":"33b5ffcca7b19a7e62c1be639f5e0ce8b8545ec3bbf935d8de564fc675f043be","value":"671557390","tokens":[]},{"address":"Ae2tdPwUPEZLYk6E3QgAE2YpN4yFNdiAziwt8q3n4JT9ckJAi9jk7UnUpmM","index":40,"txId":"3e6dbfccd8f489d6b39e3fd7f578e1711702dc68d30992154e828a2a83d4bb91","value":"400386023","tokens":[]},{"address":"Ae2tdPwUPEYxgYzB9fVuwiRbMYVKvNN6QVTu4BpHX4nxamnD9iDS6PifUQe","index":28,"txId":"488104da8c8c36fad3230e0cc35fa03fa2b4f5912f6555c80f18459d1534663b","value":"17333776821","tokens":[]},{"address":"Ae2tdPwUPEZHdQExmk6xDhxWTiG6DwDxqeiJ4TFELv7cwzLqAQZoTV8ZvLT","index":30,"txId":"4c8d2605f36d59fa75a4852f0fb6b254f56f8ebe050c2ba03ef3cb99d8cce503","value":"15972478436","tokens":[]},{"address":"Ae2tdPwUPEZJcfeGmxLHSq5bj3aNSDu6Mh71W1vtu1XFpbwh5nBELid1Mcf","index":17,"txId":"4d6ee21fbed54021f5273b36806890018c5e0c7047179df610096eee4b183588","value":"66907757","tokens":[]},{"address":"Ae2tdPwUPEZKN1hrDmjs8u2hhUK1ajZJ89Rv6kuFPVpSyEtLCZtAFJ8jzUq","index":25,"txId":"4dc19b9fdee7b2b212181c299dca9198b1a67208e5dfe578cb15878e732269d7","value":"73793720650","tokens":[]},{"address":"Ae2tdPwUPEYzJFGAygr4ZtiXWh15AHGyjjeTyknFonRc4A2xLrpNdJ9A3J2","index":16,"txId":"56ec2f5320fdd77403819ff9277d33ef78119d826e510a01c0e811cc4a2996f8","value":"1528513972","tokens":[]},{"address":"Ae2tdPwUPEYyzMoQEBwVSSWdhdE8yzy29u1p8jroVVn1tyqnTNHBUDqsBor","index":40,"txId":"6008b7f4e01b962574d89eae7a58698e70c92cfc6ddb2ffbbdc1bfc76017f52c","value":"232345173","tokens":[]},{"address":"Ae2tdPwUPEZ7nHYZnaX8hYJ2s79MZg6uFdH1N9cT97qukEJi9DutKHNDHPt","index":43,"txId":"609c3b88fd9dda968f53c6083895f56c818f3ca103657fcc12e3afbaa029816a","value":"31107252","tokens":[]},{"address":"Ae2tdPwUPEZ4KRHkM5cFGuzZcidiPznDtUUfy9HeyjX2WzT2AT7nFc6GvMo","index":32,"txId":"60d6714c2e45d55831483b174f2c8c5f1b72e050aef9cdbcb0d61800cd55b765","value":"493953549","tokens":[]},{"address":"Ae2tdPwUPEZAPVZ42aZDZ6w77zufzXCB3QFy5ALFwTGf9AU98TyRAaBqK3x","index":33,"txId":"649eb05720a517142256e2b82df2d52ec279c7aeff7d1aaad8c8ed2c3c5566de","value":"2211731133","tokens":[]},{"address":"Ae2tdPwUPEZDweGN32ZVsGhCbTyBnxsA2XuDChCTJ9j3viCYvV7LHCi3QkD","index":32,"txId":"669cd10d7e13196ecc30343c909b4a0d1249724a37b6f946ea82ec6636cc163d","value":"38088025","tokens":[]},{"address":"Ae2tdPwUPEZDjHDZ1LkUVtzrJxsJt23nCqNoEY4sdEnNtTYFvxPPqYU3w8M","index":28,"txId":"66a276d4c3153f73527c9c5e459de601982781ffcc82b84cc10aaf23dc4dcbb1","value":"4142350987","tokens":[]},{"address":"Ae2tdPwUPEZMYkK5apERfBHnzkjkg9Gq3XPWD13KtpkB3JKyQ5HWabuvDD6","index":35,"txId":"67462080f290892ff220399c574054aa46020f064eb4c5256523586814c4514a","value":"9649871784","tokens":[]},{"address":"Ae2tdPwUPEZ6g9HFQB2xLK8EPeAnEK2RgUkGvWM3s5kSsFikd1HoweWq7hX","index":51,"txId":"6aabd45bc7af02e0d8a0eb0e1084f4cc2f50cdec8dbfdb49272f391c3ac1d26d","value":"797814777","tokens":[]},{"address":"Ae2tdPwUPEYyK7nJRCfVX4vSK1Y6g5FxnhRmgioivCpxyaEzLMEMy13j1wH","index":23,"txId":"6d02813981752cfde0451fc934dbca6283eb3e15dbf8378cfadbea9003c5a5ff","value":"687964774","tokens":[]},{"address":"Ae2tdPwUPEZ9Upi1yoQbLtLnzuCATtF2GCAXVYyRUy2EcgK3L2HvbRHtgXJ","index":4,"txId":"6d0c8e93e4c463802bfd464388cb8e32b981edd19aa8c929914227705ceefbcc","value":"139334928563","tokens":[]},{"address":"Ae2tdPwUPEZDXjkqbttt58S5AeAotN41P4yNiZSnB9XjwxAaariGTbKv9qj","index":7,"txId":"739ba6beb8e2dc8ce039ecdcf620e0cdcd24874e795f4e4ed0cf566af4b5ba67","value":"114609637","tokens":[]},{"address":"Ae2tdPwUPEZ5v4dBRhwR5PdELcKQJo7oyC3bsgFSAvKkSSkmd7bGcFkeGpd","index":50,"txId":"75b624c93c3896536c098a6c066628b10c5479390a5ba07a67fa2477e717cac2","value":"13044888388","tokens":[]},{"address":"Ae2tdPwUPEZ1H2AurhLEHg64Xs7HrwPpze9BipgP9fysEgbtACt2FuQeTTW","index":40,"txId":"7b3c3e07bc2669115e690dd103f4c7f11cc530a08a564c96b11e5adf4b20ec20","value":"80318134619","tokens":[]},{"address":"Ae2tdPwUPEZ16qeZRLnL3zoK3H1A2Wh7FrWAvF5B2RsRcYyHSN6EYzrJ5Xk","index":25,"txId":"7b95bab5cb5807c5b5fa7841c9394b79d6e42335534356feba0ba0a775e9b8ed","value":"30037372","tokens":[]},{"address":"Ae2tdPwUPEZJZ1Za868x3goQKkV6xa8dq6rSDynh7YsQvkkE4j63Ujk9o65","index":38,"txId":"7f5d964b7f61b984e96e62c045bb66af308375ebba7b770f01012d7b6c402779","value":"382283144","tokens":[]},{"address":"Ae2tdPwUPEZMY1Nb9zcRyFjYkFy4pnPVbezyAgx6J5E2r68ccjWVoboKj2e","index":31,"txId":"8c077362267a9001a082b17d55a0315a0213b44ba061a3de902ab944a61bb11e","value":"98750839","tokens":[]},{"address":"Ae2tdPwUPEZALPxgEUcsM97ksyVHR4yfwN5pCb3KeAVv2ddx61NJbUyG4nh","index":31,"txId":"8f471fa892a45c046e0deffa6bf7b8cd814e883b16676fd5f000ff0afbde80d6","value":"3140947237","tokens":[]},{"address":"Ae2tdPwUPEYy6qrJttdLM4bSGkfFUy1MXBBZgHKtHgag7SkwxjjYqf8ayQq","index":43,"txId":"90a69a81be242a9be3d4a5122fd5a8e3a255b98b31c4ec54326ae4ecd689af9e","value":"193902240","tokens":[]},{"address":"Ae2tdPwUPEYw7ST7jn1MR1TkbtyGJC3hp1rLSVfgKANbVyKVx9jgGptLgB1","index":4,"txId":"90b8ebd335036a04ec96443d5d5b10983b944714cc0d4ce31cab3f5458cbc5a1","value":"933974964","tokens":[]},{"address":"Ae2tdPwUPEZEew6dKtv7QmwDt8sFiqR1DTddMMcAiruxNd6jdm7N2AuqinN","index":4,"txId":"97b815ea94da1c0f18ae3eaaae070d4a8f614e4668c0457fabf38eb19b3d0bba","value":"1671793546","tokens":[]},{"address":"Ae2tdPwUPEZBtPTRr2NK2vySSEDMfRzJSLRbz51enqLgS6RL29opZmXpBHC","index":32,"txId":"9aab6ebdb080a21c98017e2a651025be40c11ed06f99deed42b480a72ff34c05","value":"765494692","tokens":[]},{"address":"Ae2tdPwUPEYxmMcY37FUm2QqnddFJUrZCQ7fidv8Hc1nW4pw2yh5J9QgQns","index":26,"txId":"a10105341ef2ca8f188b5ff3d5ae3f849de3e9d2293a1422ebdd223392d25505","value":"24510590","tokens":[]},{"address":"Ae2tdPwUPEZ3TdBnrhBKoPA7oJY8ws3ADBTjAkpXxrgmMX6WepDk3znPjPh","index":37,"txId":"a92ecc44581b200b74ee699f5bab94327167423a65c60c79af5ac0c255cca9d2","value":"312314765","tokens":[]},{"address":"Ae2tdPwUPEZ1o1XdurvjQ5XApXXssYiThop1qSXr7Pc8pGfkDNkeJBw1tKU","index":22,"txId":"a9be6bd1428494d92143826f3776e12d2b4e7f91e8cab7700d111931d5d66130","value":"305822052","tokens":[]},{"address":"Ae2tdPwUPEZ5SBiEHpJdH9TVkFtNXvKRNQoVrywi2L6SUhckY2QCnW279np","index":23,"txId":"af5926f5e9a27933eaf15322de923f6e956581c3449fd7790dd5b1f7fbd245f1","value":"63273202","tokens":[]},{"address":"Ae2tdPwUPEZJP3cmpobTGeFy7HSdAkcfzC6bLXYUfURmmRcie2iEsy66JoS","index":40,"txId":"b510cbcce36d32bbb18073a5b7764b2be1f4e3663f5daed4fb44520dbaa3bd81","value":"72947999","tokens":[]},{"address":"Ae2tdPwUPEZNCx8rmj28N35cJC6J5Yv1pYW56xzAL2h4RAR6B2rBpmH9qan","index":35,"txId":"b60bd612584160601196c4200d7efa78289cebe2fe6b15a97141a2ea00c660b8","value":"3889297044","tokens":[]},{"address":"Ae2tdPwUPEZAVBDUH8vATd95S2Ci6CN8rcC8jBqkZXWFe7pxunG7gYNHee2","index":36,"txId":"bc5ca3382467501fdd15380f4db2c61474ff013ddf44e1f4447acce3a7b8bb2d","value":"27471469469","tokens":[]},{"address":"Ae2tdPwUPEYxuJrqYRPzxHWu2XSWLViHizasSz86XAfRZvoVhiq6ZutUKYr","index":33,"txId":"bc6cf5a2e424a69402629fd985be1e581a64d24fa81b62bd46d3c92233ea1aa1","value":"121448499","tokens":[]},{"address":"Ae2tdPwUPEZ58TeY3iQmZUVE9zMh2dMrgsLiZxeNvPEmJScwLHMCaRGGWEY","index":28,"txId":"cb00b9b4ee69c23e92085e50527d12b6e2b684dd8bbbc9e963dced4ed0057a77","value":"19818120","tokens":[]},{"address":"Ae2tdPwUPEZ5xeTrDuLZb9NHuXeGNBBtS15m9zwNDSbTpY6LzGSa6vj6ijp","index":0,"txId":"d0d6f2b631bc60a7c63cb638de8b9e1b42c9bf2b51394d7eb16151bf02698057","value":"1293535027","tokens":[]},{"address":"Ae2tdPwUPEYz9LL7ZNw89NMCoVgCiefJHsTndL2DSVZbRRWeiZdgsBTcuyW","index":26,"txId":"d51da1ca748a8cab428d9ff179cdb6ccaa434beb4420bd3bcd22917df68c3f50","value":"8724966621","tokens":[]},{"address":"Ae2tdPwUPEZ6MSSZ9qjBudbNTUzZQVxNGj4oY72niZK6i8K5vYvQQv3KBQU","index":14,"txId":"d53c278da3f8bb98ddafe02f4968842e6ad0fbd78dd088170bc8a3f6f769c4fc","value":"807650323","tokens":[]},{"address":"Ae2tdPwUPEYzP2JzoBY5d1s8F3wg75NJr1fGZoJ2Y6REncQD5WBAgWt6UQJ","index":19,"txId":"d9ce09bab025d93d7b48a24d9b74efbb3b43c29a310d34c15306b6ec10bd2706","value":"285564944","tokens":[]},{"address":"Ae2tdPwUPEZ92PQaaJCjGZf2NoQaM8CwzcwtMG5gwo8VJc9gV1c7iWvNCuA","index":28,"txId":"e2dbb4980568c56d04349dfa357e095129e18b513c2c08d74850d592c5ef4916","value":"119561387","tokens":[]},{"address":"Ae2tdPwUPEZG4NfvkEuxNPWuZike7YrzBPmQx5y7oRZCLkuHvDMm4LrfXHD","index":0,"txId":"ed3c3aed2e7f6076d34157d7d60d295f01c66642c224bb503d4e16992cab74a7","value":"200000000000","tokens":[]},{"address":"Ae2tdPwUPEZK55tLFeUzs51ogne9wwEyWwu2u5ymJfAsgrhspKHncuhaiH4","index":41,"txId":"f4b8f7ee2601cf9960aac420542e89a36613034327b164067a9b3c9e8e08f2e7","value":"4516773","tokens":[]},{"address":"Ae2tdPwUPEZ7SbbqdzDbThBK5TkLjqXf6ZYzQFzb6PDG9QJJuN4zu5apx5f","index":46,"txId":"f93953990a8df853f6501c0d9af10d9a767537f9a0e6995276a50f26ce3c7905","value":"28235960551","tokens":[]},{"address":"Ae2tdPwUPEYzsD5k5R9u8ztUW8QKUMtSNh3ToShHe9pX435twYcaPwM58BG","index":28,"txId":"fbb990590918cd9c74daf7375113a186f3668156e199c2305dbc7e215ae8a586","value":"165319500","tokens":[]}],"collateral":[],"outputs":[{"address":"DdzFFzCqrhsq3L2bZMdxxSg6H8ewY9HbyM44v3hJZauQR4eXjqnDahpCNGdvKeyZk1S3fLyZj7BVzCKKyHeyLg7EzRFMgexsvBYmHFtX","value":"141590261"},{"address":"014821c2d889e2919131df44011e16bf47c1dd0da05f2211ef92a24d9db7d0d23ea597195da08aec1d2316fbc77a1aa6821f32f02b97381da3","value":"104000000"},{"address":"DdzFFzCqrht3zk2cX3rPUNPH4RBnHPoo9GdKeCVeqBUB3SxyJJ9hpyWrobjDokNnmVCEdqXmBMwMU9jdpwPuSorvHmd3DG3aVjEnHF9W","value":"100000000"},{"address":"DdzFFzCqrhsiTBmZUY4vya1mGGTdB1utcK3mPNSuqQXJqj4dMU7kqnrvVUUz5fNe5FoBGoroVToCJbQsp3naKPQux1cXxCmH4NB8oUZK","value":"899000000"},{"address":"01d035f8cea9eaf89c7bea79a5274b736bcabe739d5d6614afa9514b335d26d541fdfdc814022360678b02f2dfb30e982eb1df3aaa30cd0a24","value":"535300000"},{"address":"01c3a388131519f40b6f41f4aa039c2ae6109ddcc83d4b3ca89efaed7417eabf85728a590b7785f27d60dea7d4bcb356b438b9d577a45547fe","value":"233199000000"},{"address":"DdzFFzCqrht67GkuqHZf9soMRMnoNGFN4c4wbByJeguVmWXfv3DpJZWw3JhBJUA3siBtiNRsu4dJHxHvMhAc75dHPP9L7Rwm16DGebP2","value":"229000000"},{"address":"DdzFFzCqrht8ekigbNpEUpEQxScPbVFaAwi7pa79CZUz5NYnV1unfkW8xQ4gVoWgyGwZmanDN3AKCPjYqHcqPELC2Ri9A1iZPxRLRkWw","value":"15125000000"},{"address":"6132b83e12c35911d50825ed98bc0847bd0d44aacbe5b122d33ce65cc7","value":"32683899500"},{"address":"01c11cafe34681dabfdd2564d70747e6fbd59e4effc020bd291a06b58fa66c2a2b76690bfbb2faadd6ff247e1db1101cfcbd47feb6d3e840d4","value":"3043395286"},{"address":"0108f1002bfe388c1ccd6a5a4f866256651227af83bef0348efeac62ae44124e8933c6b7c2d6b06da2ce65aedcb7f97340b3bee4420bca617e","value":"41957000"},{"address":"010bc4bafb1a493441636393da4e82caee44386f1f43e221017fe0d7f5da83c0388c2dd76082ced6611d2f15a99eb4c958234061b54fa74b8f","value":"1500000000"},{"address":"01656219128a9075f9cce0a465a7341a71f8dc956af2c9b0f172502b1921916f55ee18443bba9c9840d2683e0b6e5ae0247189776a5de51dd5","value":"665484720"},{"address":"0177da579addaf59b165abdecf0db51788a501d16eb9eccd0e468d77c577da579addaf59b165abdecf0db51788a501d16eb9eccd0e468d77c5","value":"77900479"},{"address":"0148defbe2ee3bd276cf70604af23ce5dac20f28ff4df6cd4dea9fd7934dafc13d6400ea5b30577769413011704786b7c99406ef73f3d14a1a","value":"121949949"},{"address":"0152f2b941db089e82d9b5bdbd24bfc1dc0ad088cbe1d5c0d921e8f92afd55c0a709ed417fc57eeba873a03ebd73854644f5ff79d6bbd6f550","value":"31900000"},{"address":"01c190bba2a7a96b11e4e35a9899911ab6cfb71e4c06b97ef4173f4557c190bba2a7a96b11e4e35a9899911ab6cfb71e4c06b97ef4173f4557","value":"99521497"},{"address":"013a3dbe375d1db71716352e5f8fd8218e103de1594b0727e607cbc2a68b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad","value":"41701000000"},{"address":"61745e69403d0561d31fc9402721a999077169b5f016ce4b20b8abdbc6","value":"9000000"},{"address":"DdzFFzCqrhse9krxMLzX7YC8XBB2e1aYi3jAAnfuDQyFDhB8vCT4kipfJQqjfsWkAjof9BSwSjxRMGm6x2FmbzKbnksyP4iqRaHZWXQ8","value":"150148261798"},{"address":"01407d8b44b5f6eec5125fbd7d28445316bd39624050fd81bcb3bc756f407d8b44b5f6eec5125fbd7d28445316bd39624050fd81bcb3bc756f","value":"49276201"},{"address":"Ae2tdPwUPEZCiUo3u5jfb8yQduTkjtZQsdVWty7aR2CHHvzYeG2wqXnJobS","value":"60753818"},{"address":"Ae2tdPwUPEZHANHz3JMyipqDQNA3yBBesfDkpckeeC4M4zjJrD48mRMD3yh","value":"44890003"},{"address":"Ae2tdPwUPEZ8mec5HYsFXk34K9WWCLwKZPwfMAsW3eJTA6fNSeq4XqUQ8h1","value":"43201926"},{"address":"Ae2tdPwUPEZHDX791vj5JdVqccqNKLwyY8ZaExg183JkxrBYxb9DZs3C87H","value":"380395318"},{"address":"Ae2tdPwUPEYzPni5wKF9tUhEkjoJKo6e5tbKaZTZ99PyKmiftJR1kCAKiZp","value":"226906912"},{"address":"Ae2tdPwUPEZ3tHJgEgfaGPHG1WYerqzoQDviW2etqNvbbsRp4Bipei9uVHY","value":"98415470144"},{"address":"Ae2tdPwUPEZ5z76UFe125848QpWU1AJGtNwofJUHCA4ksD512oEQTch4JiR","value":"97642411"},{"address":"Ae2tdPwUPEZEMpP5uQStvL4RpTPQ9eHPf1hAqe54NCeweNtvjJbaqNRNtfE","value":"6384041355"},{"address":"Ae2tdPwUPEZ724Rgqm8xNQKWvGTzi4PVow9aG9E9ZieMupK1pZkSgku5EhN","value":"13794235183"},{"address":"Ae2tdPwUPEYyE6w1pmy4zzA5DShJV3WCof2Z8tmtUSnNgZf6hk4aLHd8J64","value":"1285371436"},{"address":"Ae2tdPwUPEYzyiWWe6EqP1isioaqPsgVm8XkunNi4p7CXvhn3MvJjo1rJom","value":"18706662"},{"address":"Ae2tdPwUPEZLron47L1abrwRnDcGoWnH4sCbczx1ijo8fkF7t3fn6eJRr9k","value":"634028895"},{"address":"Ae2tdPwUPEZMrGCvJLUWjYTYeuipDBAFXdsvoGJLDpY7K887SRdAJArF3zx","value":"281847371"},{"address":"Ae2tdPwUPEZ81WhEXhbaa2bJJkARcoCR7LRMHgd72g3VzTJs5pvvivuX9YD","value":"33875503"},{"address":"Ae2tdPwUPEZAXR2ivZkLudqjNk911ktusXpNzCfjEZSBKD9Yd1k8CetU7Et","value":"52465228"},{"address":"Ae2tdPwUPEZ92MetFDxX1BAQ6ytq5GPksyjhLw8d7wiZzKUhLiz7hvdbjCS","value":"14462415"},{"address":"Ae2tdPwUPEZMazmTth9kYeN5whNbSJSkNUcVNx4V73u7y1ymYgPDEGJnCZq","value":"42999989"},{"address":"Ae2tdPwUPEYw1iSSE5otojP2Futcgowprs3bYwP6SnzV5HYtBB9jRWYp91g","value":"17599625292"},{"address":"Ae2tdPwUPEZL7RNDTJ24gTv7XsaHLk54vap9GMAEzbpi7EAcHamTua6Teqn","value":"4798173"},{"address":"Ae2tdPwUPEYvzW39gvwGLwcx7m6SGqPXZTPLBpDdJzLhuvxvftMH5cE8MNE","value":"63366458805"},{"address":"Ae2tdPwUPEYvzW39gvwGLwcx7m6SGqPXZTPLBpDdJzLhuvxvftMH5cE8MNE","value":"21795506"}],"certificate":{},"withdrawals":[],"redeemers":[],"status":true,"ttl":{"slot":25600225,"timestamp":"2021-03-31T04:55:16.000Z"}},{"hash":"1ce5e5b80ee80c1f02cba343ff2dbdf9070fb00606b892257e3d234f2a3a731a","blockHash":"e534ac967044a073f7f6bf0de4031556bb2e8590e64ade08cb26d9045c4725cb","fees":"174433","slot":364639,"epoch":256,"blockHeight":5529837,"absSlot":25593439,"timestamp":"2021-03-31T03:02:10.000Z","index":4,"inputs":[{"address":"013a3dbe375d1db71716352e5f8fd8218e103de1594b0727e607cbc2a68b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad","index":17,"txId":"1e3c7517b6fa1369c40da0a8fc1d5e123213ea228f6948614f70ea243c58b441","value":"41701000000","tokens":[]}],"collateral":[],"outputs":[{"address":"018f58e1ada3d5c29408238b9b078dc609a9188bf205ad107f1c4291808b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad","value":"41698825567"}],"certificate":{"stakeRegistrations":[{"rewardAddress":"e18b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad","index":0}],"stakeDelegations":[{"index":1,"poolKeyHash":"40d04c1367c25e6da2521f906f71bbb07858dc1d2209025364369173","rewardAddress":"e18b119f77e0dfca03b80a04267129175734cf901181a459f52bf494ad"}]},"withdrawals":[],"redeemers":[],"status":true,"ttl":{"slot":25600491,"timestamp":"2021-03-31T04:59:42.000Z"}}],"count":2}'
  # curl \
  #   -X GET "https://api.cardanoscan.io/api/v1/transaction/list?address=${addr}&pageNo=1&limit=50" \
  #   -H "apiKey: $API_KEY"
  echo "$transactions" | jq '.transactions[]'
  exit 0
done


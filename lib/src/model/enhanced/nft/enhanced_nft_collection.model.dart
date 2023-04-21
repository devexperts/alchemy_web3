import 'package:alchemy_web3/src/model/enhanced/nft/enhanced_nft.model.dart';

class EnhancedNFTCollection {
  EnhancedNFTCollection({
    required this.nfts,
    this.nextToken,
  });

  final List<EnhancedNFT> nfts;
  final String? nextToken;

  factory EnhancedNFTCollection.fromJson(Map<String, dynamic> json) =>
      EnhancedNFTCollection(
        nfts: List<EnhancedNFT>.from(
            json["nfts"].map((x) => EnhancedNFT.fromJson(x))),
        nextToken: json["nextToken"],
      );

  Map<String, dynamic> toJson() => {
        "nfts": List<dynamic>.from(nfts.map((x) => x.toJson())),
        "nextToken": nextToken,
      };


}

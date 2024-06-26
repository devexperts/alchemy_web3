import 'package:alchemy_web3/src/model/enhanced/nft/enhanced_nft/common_models/enhanced_nft_spam.model.dart';
import 'package:alchemy_web3/src/model/enhanced/nft/nft.model.dart';
import 'package:alchemy_web3/src/utils/my_logger.dart';

/// we use v2 info https://docs.alchemy.com/reference/getnftmetadata
class EnhancedNFT {
  const EnhancedNFT({
    this.contractAddress,
    this.collectionInfo,
    this.id = const EnhancedNFTId(),
    this.balance,
    this.title,
    this.description,
    this.tokenUri,
    this.media,
    this.metadata,
    this.timeLastUpdated,
    this.contractMetadata,
    this.spamInfo,
    this.acquiredAt,
    this.error,
  });

  final EnhancedNFTId id;
  final String? balance;
  final String? title;
  final String? description;
  final String? contractAddress;
  final EnhancedNFTTokenUri? tokenUri;
  final List<EnhancedNFTMedia>? media;
  final EnhancedNFTMetadata? metadata;
  final DateTime? timeLastUpdated;
  final EnhancedContractMetadata? contractMetadata;
  final EnhancedNFTSpam? spamInfo;
  final String? error;
  final EnhancedNFTCollectionInfo? collectionInfo;

//Only present if the request specified orderBy=transferTime.
  final EnhancedNFTAcquiredAt? acquiredAt;

  String? get imageUrl {
    if (metadata?.image != null && metadata!.image!.contains('ipfs.io')) {
      final cid = metadata!.image!.replaceAll('https://ipfs.io/ipfs/', '');
      return 'https://$cid.ipfs.dweb.link';
    }

    return metadata?.image;
  }

  factory EnhancedNFT.fromJson(Map<String, dynamic> json) => EnhancedNFT(
        contractAddress: () {
          try {
            if (json["contract"]["address"] != null) {
              return json["contract"]["address"].toString();
            }
          } catch (e, st) {
            globalLogger.error('error parsing contract address', e, st);
          }
        }(),
        id: () {
          try {
            return EnhancedNFTId.fromJson(json["id"]);
          } catch (e, st) {
            globalLogger.error('error parsing id', e, st);
            return EnhancedNFTId();
          }
        }(),
        title: json["title"],
        description: json["description"],
        balance: json["balance"],
        acquiredAt: () {
          try {
            return json["acquiredAt"] != null ? EnhancedNFTAcquiredAt.fromJson(json["acquiredAt"]) : null;
          } catch (e, st) {
            globalLogger.error('error parsing acquiredAt', e, st);
          }
        }(),
        tokenUri: () {
          try {
            return json["tokenUri"] != null ? EnhancedNFTTokenUri.fromJson(json["tokenUri"]) : null;
          } catch (e, st) {
            globalLogger.error('error parsing tokenUri', e, st);
          }
        }(),
        media: () {
          if (json["media"] != null) {
            List<EnhancedNFTMedia> media = [];
            for (var i in json["media"]) {
              try {
                media.add(EnhancedNFTMedia.fromJson(i));
              } catch (e, st) {
                globalLogger.error('error parsing media', e, st);
              }
            }
            return media;
          }
        }(),
        metadata: () {
//for each with try catch to add
          try {
            return json["metadata"] != null ? EnhancedNFTMetadata.fromJson(json["metadata"]) : null;
          } catch (e, st) {
            globalLogger.error('error parsing metadata', e, st);
          }
        }(),
        timeLastUpdated: json["timeLastUpdated"] != null ? DateTime.tryParse(json["timeLastUpdated"]) : null,
        contractMetadata: () {
          try {
            return json["contractMetadata"] != null
                ? EnhancedContractMetadata.fromJson(json["contractMetadata"])
                : null;
          } catch (e, st) {
            globalLogger.error('error parsing contractMetadata', e, st);
          }
        }(),
        collectionInfo: () {
          try {
            return json['collection'] != null ? EnhancedNFTCollectionInfo.fromJson(json['collection']) : null;
          } catch (e, st) {
            globalLogger.error('error parsing collectionInfo', e, st);
          }
        }(),
        spamInfo: () {
          try {
            return json["spamInfo"] != null ? EnhancedNFTSpam.fromJson(json["spamInfo"]) : null;
          } catch (e, st) {
            globalLogger.error('error parsing spamInfo', e, st);
          }
        }(),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
        "title": title,
        "description": description,
        "balance": balance,
        "collection": collectionInfo?.toJson(),
        "tokenUri": tokenUri?.toJson(),
        "media": media?.map((x) => x.toJson()),
        "metadata": metadata?.toJson(),
        "timeLastUpdated": timeLastUpdated?.toIso8601String(),
        "contractMetadata": contractMetadata?.toJson(),
        "spamInfo": spamInfo?.toJson(),
        "error": error,
      };
}

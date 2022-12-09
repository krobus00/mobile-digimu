import 'package:flutter_dotenv/flutter_dotenv.dart';

// BACKEND BASE URL
var baseURL = dotenv.env['BACKEND_BASEURL'].toString();
var baseHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

// ASSET BASE URL
var assetURL = dotenv.env['ASSET_BASEURL'].toString();
var assetMuseumURL = assetURL + "/images/museum/";

// ENDPOINT
const registerEndpoint = "user/register";
const loginEndpoint = "user/login";
const profileEndpoint = "user/profile";
const logoutEndpoint = "user/logout";

const musuemListEndpoint = "museum";

const transactionListEndpoint = "transaction";
const transactionReceiptEndpoint = "transaction_receipt";

const bannerListEndpoint = "banner";

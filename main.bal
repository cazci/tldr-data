import ballerina/http;
import ballerina/io;
import ballerina/os;
import ballerina/uuid;

public function main() returns error? {
    io:println("[INFO] Starting data feeding");
    string uuid4 = uuid:createType4AsString();
    final string API_URL = os:getEnv("API_URL");
    final string API_KEY = os:getEnv("API_KEY");
    if (API_URL == "" || API_KEY == "") {
        panic error("Config not found");
    }
    http:Client tldrClient = check new (API_URL);
    http:Response response = check tldrClient->/posts.post(headers = {"API-Key": API_KEY}, message = {title: uuid4});
    if (response.statusCode == 202) {
        io:println("[INFO] Data feeding successful");
    } else {
        io:println("[INFO] Data feeding failed");
    }
}

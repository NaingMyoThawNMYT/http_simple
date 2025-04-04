**Example:**
**Dart Code:**

```markdown
class YourSuccessResponseModel {
  final String field1;
  final int field2;
  //etc...

  YourSuccessResponseModel({
    required this.field1,
    required this.field2,
  });

  factory YourSuccessResponseModel.fromJson(Map<dynamic, dynamic> json) => YourSuccessResponseModel(
    field1: json['key_1'],
    field2: json['key_2'],
  );
}

// [response] will be either [YourSuccessResponseModel] or [ErrorCodeAndMessage]
final dynamic response = await parseAPIResponse<YourSuccessResponseModel>(
      response: post(
        tag: 'forgotPasswordRequestOTP',
        url: AppData.forgotPasswordRequestOtpURL,
        body: jsonEncode(body),
      ),
      fromJson: YourSuccessResponseModel.fromJson,
      onFailure: (ErrorCodeAndMessage error) {
        // TODO
      },
      onSuccess: (YourSuccessResponseModel success) {
        // TODO
      },
      defaultErrorMessage: 'This default error message will be used when the error cannot be detected.',
    );

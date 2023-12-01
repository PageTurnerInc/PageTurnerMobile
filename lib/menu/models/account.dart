// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

Account currentUser = Account(
                        user: 0, 
                        fullName: "Null", 
                        email: "Null", 
                        isPremium: "Null",
                      );

class Account {
    int user;
    String fullName;
    String email;
    String isPremium;

    Account ({
        required this.user,
        required this.fullName,
        required this.email,
        required this.isPremium,
    });
}

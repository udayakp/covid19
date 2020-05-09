const bcrypt = require('bcrypt');

class User {

    constructor(username, password, email) {
        this.username = username;
        this.email = email;
        this.passwordHash = this.setHashedPassword(password);
        this.createdAt = Date.now();
    }

    setHashedPassword(password) {
        return bcrypt.hashSync(password, 10);
    }

    validate() {
        errors = []
        if (this.username == "") {
            errors.push(new Error("User ID empty"));
        }
    }
}

module.exports = User;
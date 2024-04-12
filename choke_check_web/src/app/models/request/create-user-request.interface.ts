export class CreateUserRequest{
    username: String;
    password: String;
    name: String;
    surname: String;
    height: Number;
    weight: Number;
    email: String;
    age: Number;
    beltColor: String;
    rol: Number;
    sex: Number;

    constructor(username: string, password: string, name: string, surname: string, height: number, weight: number, email: string, age: number, beltColor: string, rol: number, sex: number) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.surname = surname;
        this.height = height;
        this.weight = weight;
        this.email = email;
        this.age = age;
        this.beltColor = beltColor;
        this.rol = rol;
        this.sex = sex;
    }
}
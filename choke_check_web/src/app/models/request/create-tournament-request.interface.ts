export class CreateTournamentRequest{
    title: String;
    beginDate: String;
    higherBelt: String;
    description: String;
    participants: Number;
    prize: Number;
    cost: Number;
    minWeight: Number;
    maxWeight: Number;
    sex: Number;
    authorGymId: String;

    constructor(title: String, beginDate: String, higherBelt: String, description: String, participants: Number, prize: Number, cost: Number, minWeight: Number, maxWeight: Number, sex: Number, authorGymId: String, ){
        this.title = title;
        this.beginDate = beginDate;
        this.higherBelt = higherBelt;
        this.description = description;
        this.participants = participants;
        this.prize = prize;
        this.cost = cost;
        this.minWeight = minWeight;
        this.maxWeight = maxWeight;
        this.sex = sex;
        this.authorGymId = authorGymId;
    }
}
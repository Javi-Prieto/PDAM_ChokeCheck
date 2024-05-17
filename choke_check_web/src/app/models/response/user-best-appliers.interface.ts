export interface UserBestAppliers {
    totalApplies:          number;
    userBestPublisherList: UserBestApplierList[];
}

export interface UserBestApplierList {
    name:          string;
    surname:       string;
    username:      string;
    belt:          string;
    postPublished: number;
}

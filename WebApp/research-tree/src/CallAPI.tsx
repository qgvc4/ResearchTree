import {IUser} from './Interfaces'



const hostName = "https://researchtreeapis.azurewebsites.net";

export async function createNewAccount(user: IUser): Promise<IUser>{
    const bodyData={user};
    const str = JSON.stringify(bodyData);
    const response = await fetch(hostName + "/api/Account", {body: str, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }, method:"POST"});

    return response.json();
}

export async function loginUser(email: string, password: string): Promise<IUser>{
    const bodyData={email, password};
    const str = JSON.stringify(bodyData);
    const response = await fetch(hostName + "/api/Account/Login", {body: str, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
    }, method:"POST"});

    return response.json();
}
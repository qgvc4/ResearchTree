import { LOG_IN, SIGN_UP } from './types';

export const login = (userCredential) => dispatch => {
    fetch('https://researchtreeapis.azurewebsites.net/api/Account/login', {
        method: 'POST',
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(userCredential)
    })
    .then(res => res.json())
    .then(user => dispatch({
        type:LOG_IN,
        payload: user
    }))
    .catch(error => console.error('Error: ', error));
};
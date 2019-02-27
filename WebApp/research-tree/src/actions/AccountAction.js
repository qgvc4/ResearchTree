import { LOG_IN, SIGN_UP, ERROR } from './types';

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
    .catch(error => dispatch({
        type: ERROR,
        payload: "Email or Password is not matched"
    }));
};
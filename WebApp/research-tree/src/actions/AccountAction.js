import { LOG_IN, SIGN_UP, ACCOUNT_ERROR, CLEAR_ACCOUNT_ERROR } from './types';

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
        type: ACCOUNT_ERROR,
        payload: "Email or Password is not matched"
    }));
};

export const signup = (user) => dispatch => {
    fetch('https://researchtreeapis.azurewebsites.net/api/Account', {
        method: 'POST',
        headers: {
            'content-type': 'application/json'
        },
        body: JSON.stringify(user)
    })
    .then(res => res.json())
    .then(user => dispatch({
        type:SIGN_UP,
        payload: user
    }))
    .catch(error => dispatch({
        type: ACCOUNT_ERROR,
        payload: "Sign_up error"
    }));
};

export const clearError = () => dispatch => {
    dispatch({
        type: CLEAR_ACCOUNT_ERROR,
        payload: null
    });
}
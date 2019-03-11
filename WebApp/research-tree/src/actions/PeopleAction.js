import { FETCH_USERS, PEOPLE_ERROR, CLEAR_PEOPLE_ERROR } from './types';
import { API_BASE } from './ApiConstant';

export const fetchUsers = (token) => dispatch => {
    fetch(`${API_BASE}/Users`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        }
    })
    .then(res => res.json())
    .then(users => dispatch({
        type:FETCH_USERS,
        payload: users
    }))
    .catch(error => dispatch({
        type: PEOPLE_ERROR,
        payload: "Error in fetching users"
    }));
};



export const clearError = () => dispatch => {
    dispatch({
        type: CLEAR_PEOPLE_ERROR,
        payload: null
    });
}




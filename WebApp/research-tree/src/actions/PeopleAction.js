import { FETCH_POSTS, NEW_POST, POST_ERROR, CLEAR_POST_ERROR, POST_START, POST_COMPLETE } from './types';
import { API_BASE } from './ApiConstant';

export const fetchPosts = (token) => dispatch => {
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
        type:FETCH_POSTS,
        payload: users
    }))
    .catch(error => dispatch({
        type: POST_ERROR,
        payload: "Error in fetching users"
    }));
};

export const newPost = (token, post) => dispatch => {
    postStart()
    fetch(`${API_BASE}/Users`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(post)
    })
    .then(res => res.json())
    .then(newPost => dispatch({
        type: NEW_POST,
        payload: newPost
    }))
    .then(postComplete)
    .catch(error => dispatch({
        type: POST_ERROR,
        payload: "Error in posting new users"
    }));
};

export const clearError = () => dispatch => {
    dispatch({
        type: CLEAR_POST_ERROR,
        payload: null
    });
}

export const postStart = () => dispatch => {
    dispatch({
        type: POST_START,
        payload: true
    });
}

export const postComplete = () => dispatch => {
    dispatch({
        type: POST_COMPLETE,
        payload: false
    });
}



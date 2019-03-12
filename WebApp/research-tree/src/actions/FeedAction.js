import { FETCH_POSTS, NEW_POST, POST_ERROR, CLEAR_POST_ERROR, POST_START, POST_COMPLETE, EDIT_POST, EDIT_POST_ERROR, EDIT_POST_START, EDIT_POST_COMPLETE, CLEAR_EDIT_POST_ERROR, DELETE_POST, DELETE_POST_START, DELETE_POST_ERROR, CLEAR_DELETE_POST_ERROR, DELETE_POST_COMPLETE } from './types';
import { API_BASE } from './ApiConstant';

export const fetchPosts = (token) => dispatch => {
    fetch(`${API_BASE}/Feeds`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        }
    })
    .then(res => res.json())
    .then(feeds => dispatch({
        type:FETCH_POSTS,
        payload: feeds
    }))
    .catch(error => dispatch({
        type: POST_ERROR,
        payload: "Error in fetching feeds"
    }));
};

export const newPost = (token, post) => dispatch => {
    postStart()
    fetch(`${API_BASE}/Feeds`, {
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
        payload: "Error in posting new feed"
    }));
};

export const editPost = (token, id, post) => dispatch => {
    editPostStart()
    fetch(`${API_BASE}/Feeds/${id}` , {
        method: 'PUT',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(post)
    })
    .then(res => res.json())
    .then(editPost => dispatch({
        type: EDIT_POST,
        payload: editPost
    }))
    .then(editPostComplete)
    .catch(error => dispatch({
        type: EDIT_POST_ERROR,
        payload: "Error in editing feed"
    }));
}

export const deletePost = (token, id) => dispatch => {
    deletePostStart()
    console.log(`${API_BASE}/Feeds/${id}`);
    fetch(`${API_BASE}/Feeds/${id}` , {
        method: 'DELETE',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },
    })
    .then(res => res.json())
    .then(deletePost => dispatch({
        type: DELETE_POST,
        payload: deletePost
    }))
    .then(deletePostComplete)
    .catch(error => dispatch({
        type: DELETE_POST_ERROR,
        payload: "Error in deleting feed"
    }));
}

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

export const editClearError = () => dispatch => {
    dispatch({
        type: CLEAR_EDIT_POST_ERROR,
        payload: null
    });
}

export const editPostStart = () => dispatch => {
    dispatch({
        type: EDIT_POST_START,
        payload: true
    });
}

export const editPostComplete = () => dispatch => {
    dispatch({
        type: EDIT_POST_COMPLETE,
        payload: false
    });
}

export const deleteClearError = () => dispatch => {
    dispatch({
        type: CLEAR_DELETE_POST_ERROR,
        payload: null
    });
}

export const deletePostStart = () => dispatch => {
    dispatch({
        type: DELETE_POST_START,
        payload: true
    });
}

export const deletePostComplete = () => dispatch => {
    dispatch({
        type: DELETE_POST_COMPLETE,
        payload: false
    });
}



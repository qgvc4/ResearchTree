import { FETCH_POSTS, NEW_POST, POST_ERROR, CLEAR_POST_ERROR } from '../actions/types';

const initialState = {
    feeds: [],
    newPost: {},
    error: null
};

export default function(state = initialState, action) {
    switch (action.type) {
        case FETCH_POSTS:
            return {
                ...state,
                feeds: action.payload
            };
        case NEW_POST:
            return {
                ...state,
                newPost: action.payload
            };
        case POST_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_POST_ERROR:
            return {
                ...state,
                error: action.payload
            };
        default:
            return state;
    }
}
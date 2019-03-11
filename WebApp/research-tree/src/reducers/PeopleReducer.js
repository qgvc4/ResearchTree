import { FETCH_POSTS, NEW_POST, POST_ERROR, CLEAR_POST_ERROR, POST_START, POST_COMPLETE } from '../actions/types';

const initialState = {
    users: [],
    // newPost: {},
    isLoading: false,
    error: null
};

export default function(state = initialState, action) {
    switch (action.type) {
        case FETCH_POSTS:
            return {
                ...state,
                users: action.payload
            };
        // case NEW_POST:
        //     return {
        //         ...state,
        //         newPost: action.payload
        //     };
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
        case POST_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case POST_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };
        default:
            return state;
    }
}
import { FETCH_POSTS, NEW_POST, POST_ERROR, CLEAR_POST_ERROR, POST_START, POST_COMPLETE, EDIT_POST, EDIT_POST_START, EDIT_POST_ERROR, CLEAR_EDIT_POST_ERROR, EDIT_POST_COMPLETE, DELETE_POST, DELETE_POST_START, DELETE_POST_ERROR, CLEAR_DELETE_POST_ERROR, DELETE_POST_COMPLETE } from '../actions/types';

const initialState = {
    feeds: [],
    newPost: {},
    editPost: {},
    deletePost: {},
    isLoading: false,
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
        case EDIT_POST:
            return {
                ...state,
                editPost: action.payload
            };
        case EDIT_POST_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case EDIT_POST_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_EDIT_POST_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case EDIT_POST_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };  
        case DELETE_POST:
            return {
                ...state,
                deletePost: action.payload
            };
        case DELETE_POST_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case DELETE_POST_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_DELETE_POST_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case DELETE_POST_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };     
        default:
            return state;
    }
}
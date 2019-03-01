import { LOG_IN, SIGN_UP, ACCOUNT_ERROR, CLEAR_ACCOUNT_ERROR } from '../actions/types';

const initialState = {
    user: {},
    error: null
};

export default function(state = initialState, action) {
    switch (action.type) {
        case LOG_IN:
            return {
                ...state,
                user: action.payload
            };
        case SIGN_UP:
            return {
                ...state,
                user: action.payload
            }
        case CLEAR_ACCOUNT_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case ACCOUNT_ERROR:
            return {
                ...state,
                error: action.payload
            };
        default:
            return state;
    }
}
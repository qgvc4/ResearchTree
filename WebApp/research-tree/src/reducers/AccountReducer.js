import { LOG_IN, SIGN_UP, ERROR } from '../actions/types';

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
        case ERROR:
            return {
                ...state,
                error: action.payload
            };
        default:
            return state;
    }
}
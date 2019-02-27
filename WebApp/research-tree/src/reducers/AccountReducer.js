import { LOG_IN, SIGN_UP } from '../actions/types';

const initialState = {
    user: {}
};

export default function(state = initialState, action) {
    switch (action.type) {
        case LOG_IN:
            return {
                ...state,
                user: action.payload
            };
        default:
            return state;
    }
}
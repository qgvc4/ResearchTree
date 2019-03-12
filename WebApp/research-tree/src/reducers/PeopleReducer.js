import { FETCH_USERS, PEOPLE_ERROR, CLEAR_PEOPLE_ERROR } from '../actions/types';

const initialState = {
    users: [],
    error: null
};

export default function(state = initialState, action) {
    switch (action.type) {
        case FETCH_USERS:
            return {
                ...state,
                users: action.payload
            };
        case PEOPLE_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_PEOPLE_ERROR:
            return {
                ...state,
                error: action.payload
            }
        default:
            return state;
    }
}
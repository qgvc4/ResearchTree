import { FETCH_JOBS, NEW_JOB, JOB_ERROR, CLEAR_JOB_ERROR, JOB_START, JOB_COMPLETE } from '../actions/types';

const initialState = {
    jobs: [],
    newJob: {},
    isLoading: false,
    error: null
};

export default function(state = initialState, action) {
    switch (action.type) {
        case FETCH_JOBS:
            return {
                ...state,
                jobs: action.payload
            };
        case NEW_JOB:
            return {
                ...state,
                newJob: action.payload
            };
        case JOB_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_JOB_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case JOB_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case JOB_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };
        default:
            return state;
    }
}
import { FETCH_JOBS, NEW_JOB, JOB_ERROR, CLEAR_JOB_ERROR, JOB_START, JOB_COMPLETE, EDIT_JOB_START, EDIT_JOB_ERROR, EDIT_JOB_COMPLETE, EDIT_JOB, CLEAR_EDIT_JOB_ERROR, DELETE_JOB, DELETE_JOB_START, DELETE_JOB_ERROR, CLEAR_DELETE_JOB_ERROR, DELETE_JOB_COMPLETE } from '../actions/types';

const initialState = {
    jobs: [],
    newJob: {},
    editJob: {},
    deleteJob: {},
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
        case EDIT_JOB:
            return {
                ...state,
                editJob: action.payload
            };
        case EDIT_JOB_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case EDIT_JOB_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_EDIT_JOB_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case EDIT_JOB_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };
        case DELETE_JOB:
            return {
                ...state,
                deleteJob: action.payload
            };
        case DELETE_JOB_START:
            return {
                ...state,
                isLoading: action.payload
            };
        case DELETE_JOB_ERROR:
            return {
                ...state,
                error: action.payload
            }
        case CLEAR_DELETE_JOB_ERROR:
            return {
                ...state,
                error: action.payload
            };
        case DELETE_JOB_COMPLETE:
            return {
                ...state,
                isLoading: action.payload
            };
        
        default:
            return state;
    }
}
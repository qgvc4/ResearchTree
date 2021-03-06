import { FETCH_JOBS, NEW_JOB, JOB_ERROR, CLEAR_JOB_ERROR, JOB_START, JOB_COMPLETE, EDIT_JOB, CLEAR_EDIT_JOB_ERROR, EDIT_JOB_START, EDIT_JOB_ERROR, EDIT_JOB_COMPLETE, DELETE_JOB, DELETE_JOB_START, DELETE_JOB_ERROR, CLEAR_DELETE_JOB_ERROR, DELETE_JOB_COMPLETE } from './types';
import { API_BASE } from './ApiConstant';

export const fetchJobs = (token) => dispatch => {
    fetch(`${API_BASE}/Jobs`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        }
    })
    .then(res => res.json())
    .then(jobs => dispatch({
        type:FETCH_JOBS,
        payload: jobs
    }))
    .catch(error => dispatch({
        type: JOB_ERROR,
        payload: "Error in fetching jobs"
    }));
};

export const newJob = (token, job) => dispatch => {
    jobStart()
    fetch(`${API_BASE}/Jobs`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(job)
    })
    .then(res => res.json())
    .then(newJob => dispatch({
        type: NEW_JOB,
        payload: newJob
    }))
    .then(jobComplete)
    .catch(error => dispatch({
        type: JOB_ERROR,
        payload: "Error in posting new job"
    }));
};

export const editJob = (token, id, job) => dispatch => {
    editJobStart()
    fetch(`${API_BASE}/Jobs/${id}`, {
        method: 'PUT',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify(job)
    })
    .then(res => res.json())
    .then(editJob => dispatch({
        type: EDIT_JOB,
        payload: editJob
    }))
    .then(editJobComplete)
    .catch(error => dispatch({
        type: EDIT_JOB_ERROR,
        payload: "Error in editing job"
    }));
}

export const deleteJob = (token, id) => dispatch => {
    deleteJobStart()
    fetch(`${API_BASE}/Jobs/${id}`, {
        method: 'DELETE',
        headers: {
            'Accept': 'application/json',
            'content-type': 'application/json; charset=utf-8',
            'Authorization': `Bearer ${token}`
        },

    })
    .then(res => res.json())
    .then(deleteJob => dispatch({
        type: DELETE_JOB,
        payload: deleteJob
    }))
    .then(editJobComplete)
    .catch(error => dispatch({
        type: DELETE_JOB_ERROR,
        payload: "Error in deleting job"
    }));
}

export const clearError = () => dispatch => {
    dispatch({
        type: CLEAR_JOB_ERROR,
        payload: null
    });
}

export const jobStart = () => dispatch => {
    dispatch({
        type: JOB_START,
        payload: true
    });
}

export const jobComplete = () => dispatch => {
    dispatch({
        type: JOB_COMPLETE,
        payload: false
    });
}

export const editClearError = () => dispatch => {
    dispatch({
        type: CLEAR_EDIT_JOB_ERROR,
        payload: null
    });
}

export const editJobStart = () => dispatch => {
    dispatch({
        type: EDIT_JOB_START,
        payload: true
    });
}

export const editJobComplete = () => dispatch => {
    dispatch({
        type: EDIT_JOB_COMPLETE,
        payload: false
    });
}

export const deleteClearError = () => dispatch => {
    dispatch({
        type: CLEAR_DELETE_JOB_ERROR,
        payload: null
    });
}

export const deleteJobStart = () => dispatch => {
    dispatch({
        type: DELETE_JOB_START,
        payload: true
    });
}

export const deleteJobComplete = () => dispatch => {
    dispatch({
        type: DELETE_JOB_COMPLETE,
        payload: false
    });
}



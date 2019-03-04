import { FETCH_JOBS, NEW_JOB, JOB_ERROR, CLEAR_JOB_ERROR, JOB_START, JOB_COMPLETE } from './types';
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
    jobStart()
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
    .then(jobComplete)
    .catch(error => dispatch({
        type: JOB_ERROR,
        payload: "Error in editing job"
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



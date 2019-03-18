import React, { Component } from 'react'

import JobList from './JobList'
import PostJob from './PostJob';

class Job extends Component {
    render() {
        return (
            <div>
                <PostJob />
                <hr style={{margin: "10px"}}/>
                <JobList />
            </div>
        )
    }
}

export default Job;
import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchJobs} from '../../actions/JobAction';
import UserJobCard from './UserJobCard';

class UserJobList extends Component {
    componentWillMount() {
        this.props.fetchJobs(this.props.token);
    }

    render() {
        console.log(this.props.jobs);
        if( this.props.jobs !== undefined){

        this.props.jobs.sort(function(job1,job2){
            return new Date(job1.modifyTime) - new Date(job2.modifyTime);
        });

        let jobs = this.props.jobs.filter( job => job.peopleId === this.props.id);

        const jobItems = jobs.map(job => (
            <div key={job.id}>
                <UserJobCard jobId={job.id} title={job.title} description={job.description} date={job.modifyTime}/>
            </div>
        ));
        return (
        <div>
            <h1>Jobs</h1>
            {jobItems}
        </div>
        );
        }
        return(<div><h1>Error fetching Jobs</h1></div>);
    }
}

UserJobList.propTypes = {
    fetchJobs: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    id: state.user.user.id,
    jobs: state.job.jobs,
    error: state.job.error
  })

export default connect(mapStateToProps, { fetchJobs })(UserJobList);
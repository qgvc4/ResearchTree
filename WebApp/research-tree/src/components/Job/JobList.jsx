import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchJobs} from '../../actions/JobAction';
import JobCard from './JobCard';

class JobList extends Component {

    componentWillMount() {
        this.props.fetchJobs(this.props.token);
    }

    render() {

        if( this.props.jobs !== undefined){

        this.props.jobs.sort(function(job1,job2){
            return new Date(job1.modifyTime) - new Date(job2.modifyTime);
        });
        let jobs = this.props.jobs;


        const jobItems = jobs.map(job => (
            <div key={job.id}>
                <JobCard title={job.title} description={job.description} date={job.modifyTime} major={job.major} />
            </div>
        ));
        return (
        <div>
            {jobItems}
        </div>
        );
        }
        return(<div></div>);
    }

}

JobList.propTypes = {
    fetchJobs: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    jobs: state.job.jobs,
    error: state.job.error
  })

export default connect(mapStateToProps, { fetchJobs })(JobList);
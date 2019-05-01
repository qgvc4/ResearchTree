import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchJobs} from '../../actions/JobAction';
import UserJobCard from './UserJobCard';

class UserJobList extends Component {
    constructor(){
        super();
        this.state = {modifiedState: false};

        this.modifyState = this.modifyState.bind(this);
    }


    componentWillMount() {
        this.props.fetchJobs(this.props.token);
    }

    render() {

        if( this.props.jobs !== undefined){

        this.props.jobs.sort(function(job1,job2){
            return new Date(job2.modifyTime) - new Date(job1.modifyTime);
        });

        let jobs = this.props.jobs.filter( job => job.peopleId === this.props.id);

        const jobItems = jobs.map(job => (
            <div key={job.id}>
                <UserJobCard token={this.props.token} jobId={job.id} title={job.title} description={job.description} majors={job.majors} date={job.modifyTime} modifyState={this.modifyState}/>
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

    modifyState(){
        this.setState({modifiedState: !this.state.modifiedState});
        this.props.fetchJobs(this.props.token);
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
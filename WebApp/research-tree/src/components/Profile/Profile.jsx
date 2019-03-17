import React, { Component } from 'react'
// import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import UserFeedList from './UserFeedList';
import UserJobList from './UserJobList';
import { Radio } from 'antd';
import UserInfo from './UserInfo';

const RadioButton = Radio.Button;
const RadioGroup = Radio.Group;



class Profile extends Component {
    constructor(){
        super();
        this.state = {jobsView: false};
    }

    render() {
        return (
            <div>
                { this.renderProfile() }
            </div>
        )
    }

    radioOnChange = (e) => {
        if(this.state.jobsView){
            this.setState({ jobsView: false});
        }
        else{
            this.setState({ jobsView: true});
        }
        
    }

    renderProfile() {
        return(
            <div>
                <UserInfo user={this.props.user}/>
                <div>  
                    <RadioGroup className="btn-group btn-group-toggle" defaultValue="posts" onChange={this.radioOnChange} style={{marginBottom: "30px"}} >
                        <RadioButton className="btn btn-secondary" value="posts">Posts</RadioButton>
                        <RadioButton className="btn btn-secondary" value="jobs">Jobs</RadioButton>
                    </RadioGroup>
                    </div>
                
                {this.state.jobsView ? this.displayJobs() : this.displayPosts()}
            </div>
        );
    }

    displayJobs(){
        return(<div><UserJobList /></div>);
    }

    displayPosts(){
        return(<div><UserFeedList /></div>);

    }
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(Profile);
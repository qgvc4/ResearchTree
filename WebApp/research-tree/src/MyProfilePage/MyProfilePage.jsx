import React from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

import { userActions } from '../_actions';

import { Radio, Button, Modal, Card, Input, Select, Upload, Icon } from 'antd';

const RadioButton = Radio.Button;
const RadioGroup = Radio.Group;

class MyProfilePage extends React.Component {
    componentDidMount() {
        this.props.dispatch(userActions.getAll());
    }

    handleDeleteUser(id) {
        return (e) => this.props.dispatch(userActions.delete(id));
    }

    radioOnChange(e) {

    }

    // for each jobs in user.jobs display as a card
    displayJobs(user){
        return (
            <div>
            {user.jobs.items.map((job, index) =>
                <li key={job.id}>
                    
                </li>
            )}
            </div>
        );
    }

    displayPosts(user){
        return (
            <div>
                <ul>
                    {user.posts.items.map((post, index) =>
                        <li key={post.id}>
                            
                        </li>
                    )}
                </ul>
            </div>
        );
    }

    render() {
        const { user } = this.props;
        return (
            <div>
                <div>
                    {/* User card with Avatar  */}
                    <Button>Edit Profile</Button>
                    <Modal
                        title="Edit My Profile"
                        visible={true}
                        onOk={this.handleOk}
                        onCancel={this.handleCancel}
                        >
                        
                    </Modal>
                </div>
                <div>  
                    <RadioGroup className="btn-group btn-group-toggle" defaultValue="jobs" onChange={this.radioOnChange} >
                        <RadioButton className="btn btn-secondary" value="jobs">Jobs</RadioButton>
                        <RadioButton className="btn btn-secondary" value="posts">Posts</RadioButton>
                    </RadioGroup>
                </div>
                {/* if Jobs button is pressed, display jobs, else display posts */}
            </div>
        );
    }
}

function mapStateToProps(state) {
    const { authentication } = state;
    const { user } = authentication;
    return {
        user
    };
}

const connectedMyProfilePage = connect(mapStateToProps)(MyProfilePage);
export { connectedMyProfilePage as MyProfilePage };
import React from 'react';
import { Link } from 'react-router-dom';
import { connect } from 'react-redux';

import { userActions } from '../_actions';

import { Radio, Button, Modal, Card, Input, Select, Upload, Icon } from 'antd';



const RadioButton = Radio.Button;
const RadioGroup = Radio.Group;

class MyProfilePage extends React.Component {

    constructor(props) {
        super(props);

        this.state = {profileModalVisible: false, jobsView: false};
    }

    posts = [
    {
        id: "e2r23423423rerwe",
        peopleId: "abc",
        title: "test",
        description: "test feed api put endpoint 23",
        modifyTime: "2018-10-02T15:00:06.4343237",
        attachment: null
    },
    {
        id: "er2r2423423rerwe",
        peopleId: "abc",
        title: "test",
        description: "test feed api put endpoint 23",
        modifyTime: "2018-10-02T15:00:06.4343237",
        attachment: null
    },
    {
        id: "er2r23423423rere",
        peopleId: "abc",
        title: "test",
        description: "test feed api put endpoint 23",
        modifyTime: "2018-10-02T15:00:06.4343237",
        attachment: null
    },
    ]

    jobs = [
    {
        id: "ji3jo53oi45j3o45",
        peopleId: "abc",
        title: "testjob",
        description: "test job",
        standing: 0,
        payment: true,
        majors: [0],
        modifyTime: "2018-10-02T15:00:06.4343237",
        location: 65201
    },
    {
        id: "ji34jo53oi453o45",
        peopleId: "abc",
        title: "testjob",
        description: "test job",
        standing: 0,
        payment: true,
        majors: [0],
        modifyTime: "2018-10-02T15:00:06.4343237",
        location: 65201
    },
    {
        id: "ji34jo53i45j3o45",
        peopleId: "abc",
        title: "testjob",
        description: "test job",
        standing: 0,
        payment: true,
        majors: [0],
        modifyTime: "2018-10-02T15:00:06.4343237",
        location: 65201
    },
    ]

    render() {
        const { user } = this.props;
        return (
            <div>
                <div style={{marginBottom: 20 + 'px'}}>
                    {/* User card with Avatar  */}
                    {/* <Button onClick={this.editProfileOnClick}>Edit Profile</Button>
                    <Modal
                        title="Edit My Profile"
                        visible={this.state.profileModalVisible}
                        onOk={this.handleOk}
                        onCancel={this.handleProfileCancel}
                        > 
                    </Modal> */}
                </div>
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

    componentDidMount() {
        this.props.dispatch(userActions.getAll());
    }

    handleDeleteUser(id) {
        return (e) => this.props.dispatch(userActions.delete(id));
    }

    radioOnChange = (e) => {
        if(this.state.jobsView){
            this.setState({ jobsView: false});
        }
        else{
            this.setState({ jobsView: true});
        }
        
    }


    editProfileOnClick = (e) => {
        this.setState({profileModalVisible: true});
    }

    handleProfileCancel = (e) => {
        this.setState({profileModalVisible: false});
    }

    displayJobs(){
        console.log("Jobs view");
        return (
        <div>
            {this.jobs.map((job, index) =>
                    <div style={{ background: '#ECECEC', padding: '10px' }} key={job.id}> 
                        <Card title="Job" bordered={false} style={{ width: "100%" }}>
                        <p>Card content</p>
                        <p>Card content</p>
                        <p>Card content</p>
                        </Card>
                    </div>
            )}
        </div>
        );
    }

    displayPosts(){
        console.log("Posts view");
        return (
            <div>
                {this.posts.map((post, index) =>
                        <div style={{ background: '#ECECEC', padding: '10px' }} key={post.id}>
                            <Card title="Post" bordered={false} style={{ width: "100%" }} extra={post.modifyTime}>
                            <p>Description: {post.description}</p>
                            </Card>
                        </div>
                )}  
            </div>
        );
    }
}

function mapStateToProps(state) {
    const { posts, jobs, authentication } = state;
    const { user } = authentication;
    return {
        user
    };
}

const connectedMyProfilePage = connect(mapStateToProps)(MyProfilePage);
export { connectedMyProfilePage as MyProfilePage };
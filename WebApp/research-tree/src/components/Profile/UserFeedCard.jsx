import React, { Component } from 'react'

import { Card, Button, Modal } from 'antd';
import EditPost from './EditPost';
import {deletePost} from '../../actions/FeedAction';
import { connect } from 'react-redux';

const confirm = Modal.confirm;

class UserFeedCard extends Component {

    constructor(){
        super();
        this.state = {editPostModalVisible: false};

        this.closeModal = this.closeModal.bind(this);
    }
    
    render() {
        const style = {
            float: 'right',
            margin: "0 5px"
        };

        return (
        <div>
            <Card
                title={this.props.title}
                extra={toFormattedDateString(this.props.date)}
            >
                {this.props.description}
                <Button style={style} onClick={this.showDeleteConfirm} icon="delete"/>
                <Button style={style} onClick={this.editPostOnClick} icon="form"/>
                    <Modal
                        title="Edit Post"
                        visible={this.state.editPostModalVisible}
                        onCancel={this.handlePostCancel}
                        footer={[
                            null,
                          ]}
                        > 
                        <EditPost postId={this.props.postId} closeModal={this.closeModal}/>
                    </Modal>
                
            </Card>
        </div>
        )
    }

    editPostOnClick = (e) => {
        this.setState({editPostModalVisible: true});
    }

    handlePostCancel = (e) => {
        this.setState({editPostModalVisible: false});
    }

    closeModal(){
        this.setState({editPostModalVisible: false});
        this.props.modifyState();
    }

    showDeleteConfirm = () => {
        var token = this.props.token;
        var postId = this.props.postId;
        var closeModal = this.props.modifyState;
        var deletePost = this.props.deletePost;
        confirm({
          title: 'Are you sure delete this post?',
          okText: 'Yes',
          okType: 'danger',
          cancelText: 'No',
          onOk() {
            deletePost(token, postId);
            closeModal();
            console.log('Ok');
          },
          onCancel() {
            console.log('Cancel');
          },
        });
      }
}

function toFormattedDateString(dateString) {
    const date = new Date(dateString)
    var MM = date.getMonth() + 1
    var dd = date.getDate()
    var yyyy = date.getFullYear()
    var hh = date.getHours()
    var mm = date.getMinutes()
    var ss = date.getSeconds()

    return `${MM}/${dd}/${yyyy} ${hh}:${mm}:${ss}`
}

const mapStateToProps = state => ({
   
  })

export default connect(mapStateToProps, { deletePost })(UserFeedCard);

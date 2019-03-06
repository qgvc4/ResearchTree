import React, { Component } from 'react'

import { Card, Button, Modal } from 'antd';
import EditPost from './EditPost';


export default class UserFeedCard extends Component {

    constructor(){
        super();
        this.state = {editPostModalVisible: false};
    }
    
    render() {
        const style = {
            float: 'right'
        };

        return (
        <div>
            <Card
                title={this.props.title}
                extra={toFormattedDateString(this.props.date)}
            >
                {this.props.description}
                <Button style={style} onClick={this.editPostOnClick}>Delete Post</Button>
                <Button style={style} onClick={this.editPostOnClick}>Edit Post</Button>
                    <Modal
                        title="Edit Post"
                        visible={this.state.editPostModalVisible}
                        onCancel={this.handlePostCancel}
                        footer={[
                            null,
                          ]}
                        > 
                        <EditPost postId={this.props.postId} />
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

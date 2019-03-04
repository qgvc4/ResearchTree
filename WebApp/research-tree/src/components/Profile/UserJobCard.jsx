import React, { Component } from 'react'

import { Card, Button, Modal } from 'antd';
import EditJob from './EditJob';

export default class UserJobCard extends Component {

    constructor(){
        super();
        this.state = {editJobModalVisible: false};
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

                <Button style={style} onClick={this.editJobOnClick}>Edit Job</Button>
                    <Modal
                        title="Edit Job"
                        visible={this.state.editJobModalVisible}
                        onOk={this.handleOk}
                        onCancel={this.handleJobCancel}
                        > 
                        <EditJob />
                    </Modal>
            </Card>
        </div>
        )
    }

    editJobOnClick = (e) => {
        this.setState({editJobModalVisible: true});
    }

    handleJobCancel = (e) => {
        this.setState({editJobModalVisible: false});
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

import React, { Component } from 'react'

import { Card, Button, Modal } from 'antd';
import EditJob from './EditJob';
import {deleteJob} from '../../actions/JobAction';
import { connect } from 'react-redux';
import {Majors} from '../../declaration/major';

const confirm = Modal.confirm;

class UserJobCard extends Component {

    constructor(){
        super();
        this.state = {editJobModalVisible: false};

        this.closeModal = this.closeModal.bind(this);
    }

    render() {
        const style = {
            float: 'right',
            margin: "0 5px"
        };
        const majorItems = this.props.majors.map( (value, index) => {
            return <div>{Majors[value]}</div>;
        });
        return (
        <div>
            <Card
                title={this.props.title}
                extra={toFormattedDateString(this.props.date)}
                style={{marginBottom: "5px", marginRight: "10px"}}
            >
                {this.props.description}
                <br/>
                <h5 style={{marginTop: "2em"}}>Majors:</h5>
                {majorItems}
                <Button style={style} onClick={this.showDeleteConfirm} icon="delete"/>
                <Button style={style} onClick={this.editJobOnClick} icon="form"/>
                
                    <Modal
                        title="Edit Job"
                        visible={this.state.editJobModalVisible}
                        onCancel={this.handleJobCancel}
                        footer={[
                            null,
                          ]}
                        > 
                        <EditJob jobId={this.props.jobId} closeModal={this.closeModal}/>
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

    closeModal(){
        this.props.modifyState();
        this.setState({editJobModalVisible: false});
    }

    showDeleteConfirm = () => {
        var token = this.props.token;
        var jobId = this.props.jobId;
        var closeModal = this.props.modifyState;
        var deleteJob = this.props.deleteJob;
        confirm({
          title: 'Are you sure delete this job?',
          okText: 'Yes',
          okType: 'danger',
          cancelText: 'No',
          onOk() {
            deleteJob(token, jobId);
            closeModal();
            console.log(token);
            console.log('Ok');
          },
          onCancel() {
            console.log('Cancel');
          },
        });
      }

      showMajors(){
        console.log(this.props.majors);
        this.props.majors.map( (value, index) => {
            return <div>{Majors[value]}</div>;
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

export default connect(mapStateToProps, { deleteJob })(UserJobCard);

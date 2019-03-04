import React, { Component } from 'react'

import {
    Form, Icon, Input, Button,
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {editJob} from '../../actions/JobAction'

// change this
import '../../style/Feed/postFeed.css';

const { TextArea } = Input;

class EditJob extends Component {
    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
                values["PeopleId"] = `${this.props.user.id}`;
                this.props.newPost(this.props.user.token, values);
            }
        });
    }
    
    render() {
        // if (!this.props.isLoading) {
        //     this.props.fetchPosts(this.props.user.token)
        // } 
        const { getFieldDecorator } = this.props.form;
        return (
          <Form onSubmit={this.handleSubmit} className="post-feed">
            <Form.Item>
              {getFieldDecorator('Title', {
                rules: [{ required: true, message: 'Please input your username!' }],
              })(
                <Input prefix={<Icon type="user" style={{ color: 'rgba(0,0,0,.25)' }} />} placeholder="Username" />
              )}
            </Form.Item>
            <Form.Item>
              {getFieldDecorator('Description', {
                rules: [{ required: true, message: 'Please input your Description!' }],
              })(
                <TextArea placeholder="Autosize height with minimum and maximum number of lines" autosize={{ minRows: 2, maxRows: 6 }} />
                )}
            </Form.Item>
            <Form.Item>
              <Button type="primary" htmlType="submit" className="login-form-button">
                Post
              </Button>
            </Form.Item>
          </Form>
        );
    }
}

EditJob.propTypes = {
    editJob: PropTypes.func.isRequired,
    // fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    user: state.user.user,
    error: state.job.error
})
    
const EditJobForm = Form.create({ name: 'editjob_form' })(EditJob);

export default connect(mapStateToProps, { editJob })(EditJobForm);
import React, { Component } from 'react'

import {
    Form, Icon, Input, Button,
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {newPost, fetchPosts} from '../../actions/FeedAction'

import '../../style/Feed/postFeed.css';

const { TextArea } = Input;

class PostFeed extends Component {
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
          <Form onSubmit={this.handleSubmit} className="post-feed" style={{margin: '2%'}}>
            <Form.Item>
              {getFieldDecorator('Title', {
                rules: [{ required: true, message: 'Please input a title!' }],
              })(
                <Input prefix={<Icon type="team" style={{ color: 'rgba(0,0,0,.25)' }} />} placeholder="Title" />
              )}
            </Form.Item>
            <Form.Item>
              {getFieldDecorator('Description', {
                rules: [{ required: true, message: 'Please input your Description!' }],
              })(
                <TextArea placeholder="Description" autosize={{ minRows: 2, maxRows: 6 }} />
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

PostFeed.propTypes = {
    newPost: PropTypes.func.isRequired,
    fetchPosts: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    user: state.user.user,
    feeds: state.feed.feeds,
    isLoading: state.feed.isLoading,
    error: state.feed.error
})
    
const PostForm = Form.create({ name: 'post_form' })(PostFeed);

export default connect(mapStateToProps, { fetchPosts, newPost })(PostForm);
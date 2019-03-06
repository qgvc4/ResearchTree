import React, { Component } from 'react'

import {
    Form, Input, Button,
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {editPost, fetchPosts} from '../../actions/FeedAction';

// change this
import '../../style/Feed/postFeed.css';

const { TextArea } = Input;

class EditPost extends Component {

    componentWillMount() {
      this.props.fetchPosts(this.props.user.token);
    }

    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
                values["PeopleId"] = `${this.props.user.id}`;
                this.props.editPost(this.props.user.token, this.props.postId, values);
            }
        });
    }

    render() {
        const { getFieldDecorator } = this.props.form;
        const post = this.props.feeds.filter( post => post.id === this.props.postId);
        const description = post[0].description;
        const title = post[0].title;

        console.log(post);
        return (
          <Form onSubmit={this.handleSubmit} className="post-feed">
            <Form.Item
            label="Title"
            >
              {getFieldDecorator('Title', {
                rules: [{ required: true, message: 'Please the title of your post!' }],
                initialValue: title
              })(
                <Input placeholder="Title"  />
              )}
            </Form.Item>
            <Form.Item
              label="Description"
            >
              {getFieldDecorator('Description', {
                rules: [{ required: true, message: 'Please input your Description!' }],
                initialValue: description
              })(
                <TextArea placeholder="" autosize={{ minRows: 2, maxRows: 6 }}  />
                )}
            </Form.Item>
            <Form.Item>
              <Button type="primary" htmlType="submit" className="login-form-button">
                Submit
              </Button>
            </Form.Item>
          </Form>
        );
    }
}

EditPost.propTypes = {
    editPost: PropTypes.func.isRequired,
    fetchPosts: PropTypes.func.isRequired,
}

const mapStateToProps = state => ({
    user: state.user.user,
    error: state.feed.error,
    feeds: state.feed.feeds
})
    
const EditPostForm = Form.create({ name: 'editpost_form' })(EditPost);

export default connect(mapStateToProps, { editPost, fetchPosts })(EditPostForm);
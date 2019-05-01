import React, { Component } from 'react'

import {
    Form, Icon, Input, Button,
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {newPost, fetchPosts} from '../../actions/FeedAction'
import ImageUploader from 'react-images-upload';

import '../../style/Feed/postFeed.css';

const { TextArea } = Input;

class PostFeed extends Component {
    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
          if (!err) {
              console.log('Received values of form: ', values);
              values["PeopleId"] = `${this.props.user.id}`;

              if (values["attachment"]) {
                new Promise((resolve, reject) => {
                  var reader = new FileReader();
                  reader.addEventListener("load", () => {
                      var data = reader.result;
                      var res = data.split(",");
                      var imageData = res[1];
                      resolve(imageData);
                  });
                  reader.readAsDataURL(values["attachment"]);
                }).then(imageData => {
                  values["attachment"] = imageData;
                  this.props.newPost(this.props.user.token, values);
                });
              } else {
                this.props.newPost(this.props.user.token, values);
              }
          }
        });
    }

    normFile = (e) => {
      if (Array.isArray(e) && e.length > 0) {
        return e[0];
      }
      return null;
    }
  
    
    render() {
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
            <Form.Item
            label="attachment"
          >
            {getFieldDecorator('attachment', {
              valuePropName: 'fileList',
              getValueFromEvent: this.normFile,
            })(
              <ImageUploader
              
                withIcon={true}
                withLabel={true}
                label='JPG|Size<1MB'
                buttonText='Upload attachment'
                onChange={this.onDrop}
                imgExtension={['.jpg']}
                maxFileSize={1048576}
                withPreview={true}
            />
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
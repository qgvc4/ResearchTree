import React, { Component } from 'react'

import {
    Form, Icon, Input, Button, Select
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {newJob, fetchJobs} from '../../actions/JobAction'
import {Majors} from '../../declaration/major';

import '../../style/Feed/postFeed.css';

const { TextArea } = Input;
const { Option } = Select;

class PostJob extends Component {
    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
                values["PeopleId"] = `${this.props.user.id}`;
                this.props.newJob(this.props.user.token, values);
            }
        });
    }

    validateMajorsMaxLimit = (rule, value, callback) => {
        if (value.length > 3) {
          callback('Max 3 Majors')
        } else {
          callback()
        }
      }

      validateLocationZipCode = (rule, value, callback) => {
        const pattern = /^(\d{5})?$/
        if (!pattern.test(value)) {
          callback('Not a valid ZipCode, must be 5 digits')
        } else {
          callback()
        }
      }
    
    render() {
        // if (!this.props.isLoading) {
        //     this.props.fetchPosts(this.props.user.token)
        // } 
        const { getFieldDecorator } = this.props.form;
        return (
          <Form onSubmit={this.handleSubmit} className="post-feed">
            <Form.Item style={{margin: "10px"}}>
              {getFieldDecorator('Title', {
                rules: [{ required: true, message: 'Please input a title!' }],
              })(
                <Input prefix={<Icon type="team" style={{ color: 'rgba(0,0,0,.25)' }} />} placeholder="Title" />
              )}
            </Form.Item>
            <Form.Item style={{margin: "10px"}}>
              {getFieldDecorator('Description', {
                rules: [{ required: true, message: 'Please input your Description!' }],
              })(
                <TextArea placeholder="Description" autosize={{ minRows: 2, maxRows: 6 }} />
                )}
            </Form.Item>
            <Form.Item
              label="Majors"
              style={{margin: "10px"}}
            >
              {getFieldDecorator('Majors', {
                rules: [
                  { required: true, message: 'Please select your majors!', type: 'array' },
                  { validator: this.validateMajorsMaxLimit },
                ],
              })(
                majorOptions()
              )}
          </Form.Item>
          <Form.Item
              label="Location"
              style={{margin: "10px"}}
            >
              {getFieldDecorator('Location', {
                rules: [
                  { required: true, message: 'Please input your location!', whitespace: true },
                  { validator: this.validateLocationZipCode },
                ],
              })(
                <Input placeholder="ZipCode" />
              )}
          </Form.Item>
            <Form.Item style={{margin: "10px"}}>
              <Button type="primary" htmlType="submit" >
                Create
              </Button>
            </Form.Item>
          </Form>
        );
    }
}

function majorOptions() {
    var majors = [];
    for (var i = 0; i < Majors.length; i++) {
      majors.push(<Option key={i} value={i}>{Majors[i]}</Option>)
    }
    return (
      <Select mode="multiple" placeholder="Please select majors">
        {majors}
      </Select>
    );
  }

PostJob.propTypes = {
    newJob: PropTypes.func.isRequired,
    fetchJobs: PropTypes.func.isRequired
}



const mapStateToProps = state => ({
    user: state.user.user,
    jobs: state.job.jobs,
    isLoading: state.feed.isLoading,
    error: state.feed.error
})
    
const JobForm = Form.create({ name: 'job_form' })(PostJob);

export default connect(mapStateToProps, { fetchJobs, newJob })(JobForm);
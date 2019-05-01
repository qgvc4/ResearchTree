import React, { Component } from 'react'

import {
    Form, Icon, Input, Button, Select
} from 'antd';

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {editJob, fetchJobs} from '../../actions/JobAction'

// change this
import '../../style/Feed/postFeed.css';
import {Majors} from '../../declaration/major';

const { TextArea } = Input;
const { Option } = Select;

class EditJob extends Component {

    componentWillMount() {
      this.props.fetchJobs(this.props.user.token);
    }

    handleSubmit = (e) => {
        e.preventDefault();
        this.props.form.validateFields((err, values) => {
            if (!err) {
                values["PeopleId"] = `${this.props.user.id}`;
                this.props.editJob(this.props.user.token, this.props.jobId, values);
                this.props.closeModal();
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
        const { getFieldDecorator } = this.props.form;
        const job = this.props.jobs.filter( job => job.id === this.props.jobId);
        const description = job[0].description;
        const title = job[0].title;
        const majors = job[0].majors;
        const location = job[0].location;
        return (
          <Form onSubmit={this.handleSubmit} className="post-feed">
            <Form.Item
            label="Title"
            >
              {getFieldDecorator('Title', {
                rules: [{ required: true, message: 'Please add a title!' }],
                initialValue: title
              })(
                <Input prefix={<Icon type="user" style={{ color: 'rgba(0,0,0,.25)' }} />} placeholder="Title" />
              )}
            </Form.Item>
            <Form.Item
            label="Description"
            >
              {getFieldDecorator('Description', {
                rules: [{ required: true, message: 'Please input your Description!' }],
                initialValue: description
              })(
                <TextArea placeholder="Autosize height with minimum and maximum number of lines" autosize={{ minRows: 2, maxRows: 6 }} />
                )}
            </Form.Item>
            <Form.Item
              label="Majors"
            >
              {getFieldDecorator('Majors', {
                rules: [
                  { required: true, message: 'Please select your majors!', type: 'array' },
                  { validator: this.validateMajorsMaxLimit },
                ],
                initialValue: majors || []
              })(
                majorOptions()
              )}
          </Form.Item>
          <Form.Item
              label="Location"
            >
              {getFieldDecorator('Location', {
                rules: [
                  { required: true, message: 'Please input your location!', whitespace: true },
                  { validator: this.validateLocationZipCode },
                ],
                initialValue: location
              })(
                <Input placeholder="ZipCode"/>
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

EditJob.propTypes = {
    editJob: PropTypes.func.isRequired,
    fetchJobs: PropTypes.func.isRequired,
}

const mapStateToProps = state => ({
    user: state.user.user,
    error: state.job.error,
    jobs: state.job.jobs
})
    
const EditJobForm = Form.create({ name: 'editjob_form' })(EditJob);

export default connect(mapStateToProps, { editJob, fetchJobs })(EditJobForm);
import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import { Layout } from 'antd';

import Navbar from '../Navbar';

import Job from './Job';

const {
    Content, Sider, Header,
  } = Layout;

class JobWithLayout extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ?
                        renderJob() :
                        <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderJob() {
    return(
        <div>
            <Layout>
            <Header style={{background:'#c1e791', position: 'fixed', zIndex: 1, width: '100%' }}><h1 style={{color:'white'}}>ResearchTree</h1></Header>
                <Layout>
                    <Sider style={{marginTop: '5%'}}>
                        <Navbar pageNum={['3']} />
                    </Sider>
                    <Content style={{marginTop: '6%'}}>
                        <Job />
                    </Content>
                </Layout>
            </Layout>
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(JobWithLayout);
